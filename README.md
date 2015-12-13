# Data Virtualization

data_virtualization is a gem that provides a data abstraction layer to your Rails application. It uses a federated approach to a data-virtualized database. This means that all access to the database is virtualized -- data is gathered from different sources, APIs and other databases -- and heavily cached for a somewhat longer duration, which effectively makes it a federated database. This plugin is meant for data that doesn't change all that often, and usually is not modified.

Note: this plugin assumes you are using a PostgreSQL database with support for arrays.

# Installation

First, add the gem to your dependencies

```
$ echo 'gem "data_virtualization"' >> Gemfile
$ bundle install
```

Generate the files needed for the virtualization layer. This will install the `DataSource` model, which holds the relationship between data models (which you will define later on) and objects in your database.

```
$ rails generate data_virtualization:base
```

Create your data models. These classes define how you gather the actual data, for example ActiveRecord on another database -- or an API call. They are installed in the `app/data_models/` directory. Make sure it is (auto-)loaded in your app.

```
$ rails generate data_virtualization:data_model NAME
```

You can inherit behaviour from several base classes:

```
DataVirtualization::DataModels::Base             Base implementation
DataVirtualization::DataModels::ActiveRecord     Provides basic database caching
DataVirtualization::DataModels::API              Provides API call caching
```
