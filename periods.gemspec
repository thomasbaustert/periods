# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'periods/version'

Gem::Specification.new do |spec|
  spec.name          = "periods"
  spec.version       = Periods::VERSION
  spec.authors       = ["Thomas Baustert"]
  spec.email         = ["business@thomasbaustert.de"]
  spec.summary       = %q{Simple period types like Week, Month, Quarter, Halfyear, Year.}
  spec.description   = %q{Simple period types like Week, Month, Quarter, Halfyear, Year.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
end
