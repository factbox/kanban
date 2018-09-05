require 'rails/generators'
require 'rails/generators/base'
require 'rails/generators/active_record'

class InstallGenerator < Rails::Generators::NamedBase
  include ActiveRecord::Generators::Migration

  source_root File.expand_path("../templates", __FILE__)

  def create_migrations
    Dir["#{self.class.source_root}/migrations/*.rb"].sort.each do |filepath|
      name = File.basename(filepath)
      migration_template "migrations/#{name}", "db/migrate/#{name}", skip: true
    end
  end
end
