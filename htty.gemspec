# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'htty/version'

Gem::Specification.new do |s|
  s.name        = 'htty'
  s.version     = HTTY::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Nils Jonsson']
  s.email       = ['htty@nilsjonsson.com']
  s.homepage    = 'http://htty.github.com'
  s.summary     = 'The HTTP TTY'
  s.description = 'htty is a console application for interacting with web '   +
                  "servers. It's a fun way to explore web APIs and to learn " +
                  'the ins and outs of HTTP.'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 1.8.7'

  s.add_dependency 'mime-types', '~> 1.0'

  s.add_development_dependency 'rake',  '~> 0.8'
  s.add_development_dependency 'rspec', '~> 2.0'

  s.rubyforge_project = 'htty'
  s.has_rdoc          = true

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map do |f|
                      File.basename f
                    end
  s.require_paths = %w(lib)
end
