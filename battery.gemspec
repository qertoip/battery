# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'battery/version'

Gem::Specification.new do |s|
  s.name        = 'battery'
  s.version     = Battery::VERSION
  s.authors     = ['Piotr \'Qertoip\' Włodarek']
  s.email       = ['qertoip@gmail.com']
  s.homepage    = 'https://github.com/qertoip/battery'
  s.summary     = %q{API to your laptop's battery.}
  s.required_ruby_version = '>= 1.9.2'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
