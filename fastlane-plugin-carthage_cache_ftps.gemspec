# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/carthage_cache_ftps/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-carthage_cache_ftps'
  spec.version       = Fastlane::CarthageCacheFtps::VERSION
  spec.author        = 'Wolfgang Lutz'
  spec.email         = 'wlut@num42.de'

  spec.summary       = 'Allows to publish or install the carthage builds via ftps to avoid recompilation'
  # spec.homepage      = "https://github.com/<GITHUB_USERNAME>/"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

  # spec.add_dependency 'your-dependency', '~> 1.0.0'
  spec.add_dependency 'carthage_cache'
  spec.add_dependency "double-bag-ftps"

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 2.44.1'
end
