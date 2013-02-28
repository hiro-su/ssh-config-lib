# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ssh-config-lib/version'

Gem::Specification.new do |gem|
  gem.name          = "ssh-config-lib"
  gem.version       = SSH::Config::VERSION
  gem.authors       = ["hiro-su"]
  gem.email         = ["h.sugipon@gmail.com"]
  gem.description   = %q{The library for editing ssh config.}
  gem.summary       = %q{The library for editing ssh config.}
  gem.homepage      = "https://github.com/hiro-su/ssh-config-lib"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
