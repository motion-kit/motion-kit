# -*- encoding: utf-8 -*-
require File.expand_path('../lib/motion-kit/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'motion-kit'
  gem.version       = MotionKit::VERSION
  gem.licenses      = ['BSD']

  gem.authors = ['Colin T.A. Gray', 'Jamon Holmgren']
  gem.email   = ['colinta@gmail.com', 'jamon@clearsightstudio.com']
  gem.summary     = %{The RubyMotion layout and styling gem.}
  gem.description = <<-DESC
MotionKit, for RubyMotion, is a DSL for creating and styling views in iOS and OS X.
DESC

  gem.homepage    = 'https://github.com/rubymotion/motion-kit'

  gem.files       = Dir.glob('lib/**/*.rb')
  gem.files      << 'README.md'
  gem.test_files  = Dir.glob('spec/**/*.rb')

  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'dbt', '~> 1.1', '>= 1.1.5'
end
