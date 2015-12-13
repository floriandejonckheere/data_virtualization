require 'rails/generators'
require 'rails/generators/migration'

# Base Generator - generates base files for virtualization layer
module DataVirtualization
  class BaseGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates/', File.dirname(__FILE__))

    def copy_cache_initializer_file
      copy_file 'cache_initializer.rb', 'config/initializers/cache.rb'
    end

    def create_data_source_model
      template 'data_source.rb', 'app/models/data_source.rb'
      migration_template 'create_data_sources.rb', 'db/migrate/create_data_sources.rb'
    end

    def self.next_migration_number(path)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end
  end
end
