# -*- encoding: utf-8 -*-
require File.expand_path('../lib/flix/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrew Gertig"]
  gem.email         = ["andrew@otherscreen.com"]
  gem.description   = %q{API wrapper}
  gem.summary       = %q{Walking through the process of creating an API client}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "flix"
  gem.require_paths = ["lib"]
  gem.version       = Flix::VERSION
end
