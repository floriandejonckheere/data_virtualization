module DataVirtualization
  module DataSource
    extend ActiveSupport::Concern

    included do
      def data_model
        klass = "#{DataVirtualization.data_model_module}::#{self.name.camelize}"
        begin
          return klass.constantize
        rescue NameError
          raise Errors::NoDataModelError, "data model class #{klass} not found"
        end
      end

      def valid_cache?
        p "cache for #{self.name} #{self.data_entity.id}: #{self.cache_timestamp}"
        return false unless self.cache_timestamp
        return ((Time.now - self.cache_timestamp) <= data_model.valid_for)
      end

      def validate_cache!
        self.update_column :cache_timestamp, Time.now
      end

      def invalidate_cache!
        self.update_column :cache_timestamp, nil
      end
    end

  end
end
