# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webpagetest/version'

Gem::Specification.new do |spec|
  spec.name          = "webpagetest"
  spec.version       = Webpagetest::VERSION
  spec.authors       = ["Sebastián Vicencio"]
  spec.email         = ["sivicencio@gmail.com"]
  spec.description   = %q{A Ruby wrapper for the Webpagetest REST API.}
  spec.summary       = %q{Ruby wrapper for the Webpagetest API}
  spec.homepage      = "https://github.com/sivicencio/webpagetest-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "awesome_print"
  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "json"
  spec.add_runtime_dependency "hashie"
end
