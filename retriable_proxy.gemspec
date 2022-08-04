# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'retriable_proxy/version'

Gem::Specification.new do |s|
  s.name = "retriable_proxy"
  s.version = RetriableProxy::VERSION

  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  s.require_paths = ["lib"]
  s.authors = ["Julik Tarkhanov"]
  s.description = "Adds an object wrapper on top of Retriable"
  s.email = "me@julik.nl"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = `git ls-files -z`.split("\x0")
  s.homepage = "http://github.com/julik/retriable_proxy"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Retry arbitrary method calls on a given object, no matter its class"
  s.specification_version = 4

  s.add_runtime_dependency(%q<retriable>, [">= 2.0", "< 4.0"])
  s.add_development_dependency(%q<rspec>, ["~> 3.2.0"])
  s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
  s.add_development_dependency(%q<rake>, ["~> 10"])
  s.add_development_dependency(%q<bundler>, ["~> 2.0"])
end
