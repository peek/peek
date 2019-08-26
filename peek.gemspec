# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'peek/version'

Gem::Specification.new do |gem|
  gem.name          = 'peek'
  gem.version       = Peek::VERSION
  gem.authors       = ['Garrett Bjerkhoel']
  gem.email         = ['me@garrettbjerkhoel.com']
  gem.description   = %q{Take a peek into your Rails application.}
  gem.summary       = %q{Take a peek into your Rails application.}
  gem.homepage      = 'https://github.com/peek/peek'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'railties', '>= 4.0.0'
end
