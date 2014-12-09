unless defined?(Motion::Project::Config)
  raise "The MotionKit gem must be required within a RubyMotion project Rakefile."
end


require 'dbt'


Motion::Project::App.setup do |app|
  core_lib = File.join(File.dirname(__FILE__), 'motion-kit')
  cocoa_lib = File.join(File.dirname(__FILE__), 'motion-kit-cocoa')
  platform = app.respond_to?(:template) ? app.template : :ios
  if platform.to_s.start_with?('ios')
    platform_name = 'ios'
  elsif platform.to_s.start_with?('osx')
    platform_name = 'osx'
  end
  platform_lib = File.join(File.dirname(__FILE__), "motion-kit-#{platform_name}")
  unless File.exists? platform_lib
    raise "Sorry, the platform #{platform.inspect} (aka #{platform_name}) is not supported by MotionKit"
  end

  # scans app.files until it finds app/ (the default)
  # if found, it inserts just before those files, otherwise it will insert to
  # the end of the list
  insert_point = app.files.find_index { |file| file =~ /^(?:\.\/)?app\// } || 0

  Dir.glob(File.join(platform_lib, '**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end
  Dir.glob(File.join(cocoa_lib, '**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end
  Dir.glob(File.join(core_lib, '**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end

  DBT.analyze(app)
end
