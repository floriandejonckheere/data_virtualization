$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'data_virtualization/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'data_virtualization'
  s.version     = DataVirtualization::VERSION
  s.authors     = ['Florian Dejonckheere']
  s.email       = ['florian@dejonckhee.re']
  s.homepage    = 'https://www.github.com/floriandejonckheere/data_virtualization'
  s.summary     = 'data virtualization layer for Ruby on Rails'
  s.description = 'Creates a virtual federated database layer that harmonizes and integrates data from various sources'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE.md', 'Rakefile', 'README.md']
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 4.2.5'

  s.add_development_dependency 'sqlite3'
end
