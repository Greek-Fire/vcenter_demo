require File.expand_path('lib/foreman_vcenter_demo/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'foreman_vcenter_demo'
  s.version     = ForemanPluginTemplate::VERSION
  s.metadata    = { 'is_foreman_plugin' => 'true' }
  s.license     = 'GPL-3.0'
  s.authors     = ['Louis Tiches']
  s.email       = ['ltiches@hallastech.com']
  s.homepage    = 'https://gogle.com'
  s.summary     = 'Summary of ForemanPluginTemplate.'
  # also update locale/gemspec.rb
  s.description = 'Description of ForemanPluginTemplate.'


  s.required_ruby_version = '>= 2.7', '< 4'

  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-minitest'
  s.add_development_dependency 'rubocop-performance'
  s.add_development_dependency 'rubocop-rails'
end
