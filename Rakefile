# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")

platform = ENV.fetch('platform', 'ios')
if platform == 'ios'
  require 'motion/project/template/ios'
elsif platform == 'osx'
  require 'motion/project/template/osx'
elsif platform == 'tvos'
  require 'motion/project/template/tvos'
end

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end


Motion::Project::App.setup do |app|
  app.name = 'MotionKit'
  app.identifier = 'com.motionkit.MotionKit'

  if app.template == :ios
    app.specs_dir = 'spec/ios/'
    app.files.delete_if { |file| file =~ %r{app/osx/} }
    app.files.delete_if { |file| file =~ %r{app/tvos/} }
  elsif app.template == :osx
    app.specs_dir = 'spec/osx/'
    app.files.delete_if { |file| file =~ %r{app/ios/} }
    app.files.delete_if { |file| file =~ %r{app/tvos/} }
  elsif app.template == :tvos
    app.specs_dir = 'spec/tvos/'
    app.files.delete_if { |file| file =~ %r{app/ios/} }
    app.files.delete_if { |file| file =~ %r{app/osx/} }
  end

  DBT.analyze(app)
end
