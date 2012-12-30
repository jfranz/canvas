# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'canvas/version'

Gem::Specification.new do |gem|
  gem.name          = "canvas"
  gem.version       = Canvas::VERSION
  gem.authors       = ["Jeremy Franz"]
  gem.email         = ["jfranz@gmail.com"]
  gem.description   = %q{Canvas LMS API client}
  gem.summary       = %q{Canvas LMS API wrapper}
  gem.homepage      = ""

  gem.add_development_dependency "rspec"
  gem.add_development_dependency 'webmock', '~> 1.9.0'
  gem.add_runtime_dependency "faraday", '>= 0.8.4'
  gem.add_runtime_dependency "faraday_middleware", '>= 0.9.0'
  gem.add_runtime_dependency "multi_json", '>= 1.3'
  gem.add_runtime_dependency "hashie", '~> 1.2.0'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
