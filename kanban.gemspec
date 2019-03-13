$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'kanban/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'kanban'
  s.version     = Kanban::VERSION
  s.authors     = ['Phelipe Wener']
  s.email       = ['phwener@gmail.com']
  s.homepage    = 'https://github.com/factbox/kanban' # TODO: change
  s.summary     = 'Summary of artifact plugin'
  s.description = 'Description of artifact plugin'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.2.1'
end
