require 'rubygems'
require 'bundler/setup'
require 'pg'
require 'active_record'
require 'yaml'

namespace :db do
  desc 'Migrate the database'
  task :migrate do
    connection_details = YAML.load(File.open("config/database.yml"))
    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::MigrationContext.new("db/migrate", ActiveRecord::SchemaMigration).migrate
  end

  desc 'Create the database'
  task :create do
    connection_details = YAML.load(File.open("config/database.yml"))
    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::Base.connection.create_database(connection_details['database'])
  end

  desc 'Drop the database'
  task :drop do
    connection_details = YAML.load(File.open("config/database.yml"))
    ActiveRecord::Base.establish_connection(connection_details)
    ActiveRecord::Base.connection.drop_database(connection_details['database'])
  end
end
