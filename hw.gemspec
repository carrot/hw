# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hw/version', __FILE__)

Gem::Specification.new do |gem|
  gem.description = %q{Package manager for random tasks}
  gem.summary     = %q{}
  gem.license     = 'MIT'

  gem.author   = 'Tom Milewski'
  gem.email    = 'tmilewski@gmail.com'
  gem.homepage = 'http://carrot.is/tom'

  gem.add_dependency 'bundler'
  gem.add_dependency 'thor', ">= 0.14.6", "< 2.0"
  gem.add_dependency 'rails'
  gem.add_dependency 'rake'
  gem.add_dependency 'httparty'
  gem.add_dependency 'pg'
  gem.add_dependency 'git'

  gem.add_development_dependency 'rspec-rails'
  gem.add_development_dependency "ruby-prof"
  gem.add_development_dependency "debugger"
  gem.add_development_dependency "ronn"
  gem.add_development_dependency "rspec", "~> 2.11"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "sqlite3"

  gem.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hw"
  gem.require_paths = ["lib"]
  gem.version       = HW::VERSION

  # TODO: Fails with TravisCI
  # gem.signing_key = '/Users/tmilewski/.gemcert/hw-private_key.pem'
  # gem.cert_chain  = ['hw-public_cert.pem']
end
