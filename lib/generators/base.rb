require 'rails/generators'
require 'rails/generators/migration'

# Base Generator - generates base files for virtualization layer
module DataVirtualization
  class BaseGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates/', File.dirname(__FILE__))

    def create_initializer
      copy_file 'config/initializers/data_virtualization.rb', 'config/initializers/data_virtualization.rb'
    end

    def create_data_source_model
      template 'app/models/data_source.rb', 'app/models/data_source.rb'
      migration_template 'db/migrate/create_data_sources.rb', 'db/migrate/create_data_sources.rb'
    end

    def self.next_migration_number(path)
      Time.now.utc.strftime('%Y%m%d%H%M%S')
    end
  end
end
