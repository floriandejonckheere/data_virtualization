require 'rails/generators'

# Data Model Generator - generates data model class
module DataVirtualization
  class DataModelGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates/', File.dirname(__FILE__))

    def create_data_model
      template 'app/data_models/data_model.rb', "app/data_models/#{file_name}.rb"
    end
  end
end
