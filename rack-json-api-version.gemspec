# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/json/api/version/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-json-api-version"
  spec.version       = Rack::Json::Api::Version::VERSION
  spec.authors       = ["Daniel Mantilla"]
  spec.email         = ["dan@appcabinet.com"]
  spec.summary       = %q{Middleware to extract the API version from request headers}
  spec.description   = %q{Middleware to extract the API version from request headers. Check documentation for details}
  spec.homepage      = "http://github.com/dmantilla/rack-json-api-version"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
