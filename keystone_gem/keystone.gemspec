# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'keystone_engine/version'

Gem::Specification.new do |spec|
  spec.name          = "keystone-engine"
  spec.version       = KeystoneEngine::VERSION
  spec.authors       = ["Sascha Schirra"]
  spec.email         = ["sashs@scoding.de"]
  spec.license       = 'GPL-2.0'
  spec.summary       = %q{Ruby binding for Keystone}
  spec.description   = %q{Ruby binding for Keystone <Keystone-engine.org>}
  spec.homepage      = "https://keystone-engine.org"

  spec.files         = Dir["lib/keystone_engine/*.rb"] + Dir["lib/keystone_engine.rb"] 
  spec.require_paths = ["lib"]
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_runtime_dependency "ffi", "~> 1.9"
end
