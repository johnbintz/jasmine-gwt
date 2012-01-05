# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jasmine-gwt/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["John Bintz"]
  gem.email         = ["john@coswellproductions.com"]
  gem.description   = %q{Given-When-Then syntax for Jasmine that looks suspiciously like Cucumber}
  gem.summary       = %q{Given-When-Then syntax for Jasmine that looks suspiciously like Cucumber}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "jasmine-gwt"
  gem.require_paths = ["lib"]
  gem.version       = Jasmine::GWT::VERSION
end
