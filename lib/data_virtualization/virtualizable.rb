module DataVirtualization
  module Virtualizable
    extend ActiveSupport::Concern

    included do
      def valid_cache?
        self.data_sources.each { |ds| return false unless ds.valid_cache? }
        true
      end

      def invalidate_cache!
        self.data_sources.each { |ds| ds.invalidate_cache! }
      end

      def clear_cache!
        invalidate_cache!

        update_columns self.class.data_mapping.keys.zip([]).to_h
      end

      private
      def resolve_data_source(data_source_sym)
        self.data_sources.find_by(:name => data_source_sym.to_s)
      end
    end

    module ClassMethods
      def acts_as_virtualizable(options = {})
        class << self
          attr_accessor :data_mapping
        end

        @data_mapping ||= {}

        has_many :data_sources, :as => :data_entity
      end

      def inherited(subclass)
        super
        deep_dup = @data_mapping.deep_dup
        subclass.instance_variable_set('@data_mapping', deep_dup)
      end

      def federate(*args)
        raise DataVirtualization::Errors::InvalidMappingError 'need at least two params' if args.length < 2
        opts = args.select { |h| h.is_a? Hash }
        overwrite = (opts.detect { |h| h.key? :overwrite } || { :overwrite => false })[:overwrite]
        target = opts.detect { |hash| hash.key? :to }[:to]
        raise DataVirtualization::Errors::InvalidMappingError 'not target specified' unless target

        args.reject { |arg| arg.is_a? Hash }.each do |attribute|
          if overwrite
            @data_mapping[attribute] = [target]
          else
            (@data_mapping[attribute] ||= []) << target
          end

          # Define datasource-specific accessor
          define_method("#{attribute.to_s}_#{target.to_s}") do
            data_source = resolve_data_source target
            raise Errors::NoDataSourceError if data_source.nil?
            raise Errors::NoDataKeyError unless data_source.keys

            values = []
            data_source.keys.each do |key|
              value = data_source.data_model.send(attribute, key)
              values += Array value
            end
            values
          end

          # Define global accessor (if not defined before)
          define_method(attribute.to_s) do
            raise Errors::InvalidMappingError "no mapping defined for attribute #{attribute.to_s}" unless self.class.data_mapping.key? attribute

            data_source_syms = self.class.data_mapping[attribute]
            raise Errors::InvalidMappingError "no mapping defined for attribute #{attribute.to_s}" unless data_source_syms

            valid = true
            resolved_data_sources = []
            data_source_syms.each do |data_source_sym|
              data_source = resolve_data_source data_source_sym
              raise Errors::NoDataSourceError unless data_source
              resolved_data_sources << data_source

              valid = false unless data_source.valid_cache?
            end

            if valid
              # Cache hit
              return read_attribute attribute
            else
              # Cache miss
              value = []
              resolved_data_sources.each do |resolved_data_source|
                value += Array send("#{attribute.to_s}_#{resolved_data_source.name}".to_sym)
                resolved_data_source.validate_cache!
              end
              value.uniq!

              # TODO: update group of attributes instead of single attribute
              # Use update_column to avoid using default accessors which result in a loop
              update_column attribute, value
              value
            end
          end unless self.respond_to? attribute
        end
      end
    end

  end
end

ActiveRecord::Base.send :include, DataVirtualization::Virtualizable
