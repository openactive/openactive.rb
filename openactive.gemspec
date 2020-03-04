# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openactive/version'

Gem::Specification.new do |spec|
  spec.name          = "openactive"
  spec.version       = OpenActive::VERSION
  spec.authors       = ["ldodds"]
  spec.email         = ["leigh.dodds@theodi.org"]
  spec.description   = %q{OpenActive client library}
  spec.summary       = %q{OpenActive client library}
  spec.homepage      = "https://github.com/openactive/openactive.rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ['~> 2.4']

  spec.add_dependency "rest-client", ">= 1.8.0"
  spec.add_dependency "json"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "simplecov-rcov"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-pride"
  spec.add_development_dependency "rspec-expectations"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"

end
