lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sfrest/version'
Gem::Specification.new do |s|
  s.name        = 'sfrest'
  s.version     = SFRest::VERSION
  s.date        = '2022-02-11'
  s.summary     = "Acquia Site Factory Rest API."
  s.description = "Wrapper methods around the ACSF Rest API."
  s.authors     = [
      'ACSF Engineering'
  ]
  s.files       = Dir['lib/**/*.rb']
  s.homepage    =
      'http://github.com/acquia/sf-sdk-ruby'
  s.license     = 'APACHE-2.0'

  s.add_dependency('excon')

  s.add_development_dependency('bundler')
  s.add_development_dependency('faker')
  s.add_development_dependency('rspec')
  s.add_development_dependency('simplecov')
  s.add_development_dependency('webmock')
end
