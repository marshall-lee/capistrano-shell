# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-shell'
  spec.version       = '0.2.0'
  spec.authors       = ['Vladimir Kochnev']
  spec.email         = ['hashtable@yandex.ru']

  spec.summary       = 'Opens SSH shell on remote host in current release directory'
  spec.homepage      = 'https://github.com/marshall-lee/capistrano-shell'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_dependency 'capistrano', '~> 3.1'
end
