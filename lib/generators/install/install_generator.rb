require 'rails/generators'
require 'rails/generators/base'
require 'rails/generators/active_record'

# Generator to install all code that plugin needs to work
class InstallGenerator < Rails::Generators::NamedBase
  include ActiveRecord::Generators::Migration

  source_root File.expand_path('../templates', __FILE__)

  def create_migrations
    migration_order = [
      'create_layers',
      'create_stories',
      'create_criteria'
    ]
    migration_order.each do |filename|
      generate_migration filename
    end
  end

  def create_controllers
    get_dir_path('controllers').sort.each do |filepath|
      name = File.basename(filepath)
      copy_file "controllers/#{name}", "app/controllers/#{name}"
    end
  end

  def create_components
    get_dir_path('javascript/components').sort.each do |filepath|
      name = File.basename(filepath)
      copy_file "javascript/components/#{name}",
                "app/javascript/components/#{name}"
    end
  end

  def create_models
    get_dir_path('models').sort.each do |filepath|
      name = File.basename(filepath)
      copy_file "models/#{name}", "app/models/#{name}"
    end
  end

  def create_views
    directory 'views/stories', 'app/views/stories'
  end

  def create_routes
    route "resources :stories, controller: 'artifacts'"
    route "get '/kanban/:id/move/:layer', to: 'layers#move'"
  end

  private

  def get_dir_path(folder)
    Dir["#{self.class.source_root}/#{folder}/*"]
  end

  def generate_migration(filepath)
    name = File.basename("migrations/#{filepath}.rb")
    migration_template "migrations/#{name}", "db/migrate/#{name}", skip: true
  end
end
