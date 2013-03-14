# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'glimpse/version'

Gem::Specification.new do |gem|
  gem.name          = 'glimpse'
  gem.version       = Glimpse::VERSION
  gem.authors       = ['Garrett Bjerkhoel']
  gem.email         = ['me@garrettbjerkhoel.com']
  gem.description   = %q{Provide a glimpse into your Rails application.}
  gem.summary       = %q{Provide a glimpse into your Rails application.}
  gem.homepage      = 'https://github.com/dewski/glimpse'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'rails', '>= 3'
end
