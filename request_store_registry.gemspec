# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'request_store_registry/version'

Gem::Specification.new do |spec|
  spec.name          = "request_store_registry"
  spec.version       = RequestStoreRegistry::VERSION
  spec.authors       = ["Andrew Volozhanin"]
  spec.email         = ["linuxheadrus@gmail.com"]
  spec.summary       = %q{RequestStore API similar to ActiveSupport::PerThreadRegistry}
  spec.description   = %q{This gem provides API for RequestStore, that is similar to ActiveSupport::PerThreadRegistry API}
  spec.homepage      = "https://github.com/scarfacedeb/request_store_registry"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '~> 4.1'
  spec.add_dependency 'request_store', '~> 1.1'
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
