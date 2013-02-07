# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'keener/version'

Gem::Specification.new do |gem|
  gem.name          = "keener"
  gem.version       = Keener::VERSION
  gem.authors       = ["Mateo Murphy"]
  gem.email         = ["mateo.murphy@gmail.com"]
  gem.description   = %q{Unofficial gem for accessing keen.io}
  gem.summary       = %q{An unofficial gem for accessing keen.io}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'faraday', "~> 0.8.5"
  gem.add_dependency 'faraday_middleware', '~> 0.9.0'
  gem.add_dependency 'hashie', '~> 1.2.0'

  gem.add_development_dependency "rspec", "~> 2.12"
  gem.add_development_dependency "vcr", "~> 2.4.0"
end
