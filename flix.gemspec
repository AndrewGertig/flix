# -*- encoding: utf-8 -*-
require File.expand_path('../lib/flix/version', __FILE__)

Gem::Specification.new do |gem|
  # gem.add_dependency 'faraday', '~> 0.8'
  gem.add_dependency 'faraday_middleware', '~> 0.8'
  gem.add_dependency 'multi_json', '~> 1.3'
  gem.add_dependency 'simple_oauth', '~> 0.1.6'
  
  gem.add_development_dependency 'json'
    
  gem.authors       = ["Andrew Gertig"]
  gem.email         = ["andrew@otherscreen.com"]
  gem.description   = %q{A Ruby wrapper for the API}
  gem.summary       = %q{API client}
  gem.homepage      = "https://github.com/AndrewGertig/flix"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "flix"
  gem.require_paths = ["lib"]
  gem.version       = Flix::VERSION
end
