# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'papapi/version'

Gem::Specification.new do |spec|
  spec.name          = "papapi"
  spec.version       = Papapi::VERSION
  spec.authors       = ["Dmitry Nizovtsev"]
  spec.email         = ["dmitry@rubyriders.com"]
  spec.summary       = %q{A client for the Post Affiliate Pro API}
  spec.homepage      = "https://github.com/JSBizon/papapi"
  spec.description   = "Low level API for Post Affiliate Pro GridRequest, FormRequest, etc"
  spec.license       = "MIT"
  

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "rspec", "~> 3.2"
end
