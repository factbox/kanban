require 'rails/generators'
require 'rails/generators/base'
require 'rails/generators/active_record'

class InstallGenerator < Rails::Generators::NamedBase
  include ActiveRecord::Generators::Migration

  source_root File.expand_path("../templates", __FILE__)

  def create_migrations
    get_dir_path('migrations').sort.each do |filepath|
      name = File.basename(filepath)
      migration_template "migrations/#{name}", "db/migrate/#{name}", skip: true
    end
  end

  def create_models
    get_dir_path('models').sort.each do |filepath|
      name = File.basename(filepath)
      copy_file "models/#{name}", "app/models/#{name}"
    end
  end

  def create_views
    directory "views/stories", "app/views/stories"
  end

  private

    def get_dir_path(folder)
      Dir["#{self.class.source_root}/#{folder}/*.rb"]
    end

end
