# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hw/version', __FILE__)

Gem::Specification.new do |gem|
  gem.description = %q{Package manager for random tasks}
  gem.summary     = %q{}
  gem.license     = 'MIT'

  gem.author   = 'Tom Milewski'
  gem.email    = 'tmilewski@gmail.com'
  gem.homepage = 'http://carrot.is/tom'

  gem.add_dependency 'thor', ">= 0.14.6", "< 2.0"
  gem.add_dependency 'rails', "~> 4.0"
  gem.add_dependency 'railties', "~> 4.0"
  gem.add_dependency 'git'

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
