# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 's98/backbone/rails/extensions/version'

Gem::Specification.new do |spec|
  spec.name          = "s98-backbone-rails-extensions"
  spec.version       = S98::Backbone::Rails::Extensions::VERSION
  spec.authors       = ["PedroSena"]
  spec.email         = ["sena.pedro@gmail.com"]
  spec.description   = %q{Backbone extensions and common code that will be used on different projects}
  spec.summary       = %q{Backbone extensions and common code that will be used on different projects}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files = Dir["{lib,vendor}/**/*"] #+ ["MIT-LICENSE", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", "~> 3.1"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
