# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'icwot/version'

Gem::Specification.new do |spec|
  spec.name          = "icwot"
  spec.version       = Icwot::version
  spec.authors       = ["leo"]
  spec.email         = ["facenord.sud@gmail.com"]
  spec.description   = %q{icwot : RESTfull sinatra server providing inversion of control for logging messages from another web-server}
  spec.summary       = %q{icwot: inversion of control in RESTful applications}
  spec.homepage      = "https://github.com/facenord-sud/icwot"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rake'

  spec.add_dependency 'bundler', '~> 1.3'
  spec.add_dependency 'sinatra', '~> 1.4.4'
  spec.add_dependency 'thin'
  spec.add_dependency 'rest-client', '~> 1.6.7'
  spec.add_dependency 'json', '~> 1.8.1'
end
