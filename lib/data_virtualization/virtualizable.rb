module DataVirtualization
  module Virtualizable
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_virtualizable(options = {})
        class << self
          attr_accessor :data_mapping
        end

        @data_mapping ||= {}

        has_many :data_sources, :as => :data_model
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
        end
      end
    end

  end
end

ActiveRecord::Base.send :include, DataVirtualization::Virtualizable
