# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'keepasser/version'

Gem::Specification.new do |spec|
  spec.name          = 'keepasser'
  spec.version       = Keepasser::VERSION
  spec.authors       = ['Sam Pikesley']
  spec.email         = ['sam.pikesley@gmail.com']

  spec.summary       = %q{Fix divergent KeepassX files}
  spec.description   = %q{Because Dropbox is bad}
  spec.homepage      = 'http://pikesley.org'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'thor', '~> 0.19'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
end
