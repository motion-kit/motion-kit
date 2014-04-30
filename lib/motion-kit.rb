unless defined?(Motion::Project::Config)
  raise "The MotionKit gem must be required within a RubyMotion project Rakefile."
end


Motion::Project::App.setup do |app|
  core_lib = File.join(File.dirname(__FILE__), 'motion-kit')
  cocoa_lib = File.join(File.dirname(__FILE__), 'motion-kit-cocoa')
  platform = app.respond_to?(:template) ? app.template : :ios
  platform_lib = File.join(File.dirname(__FILE__), "motion-kit-#{platform}")
  unless File.exists? platform_lib
    raise "Sorry, the platform #{platform.inspect} is not supported by MotionKit"
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
end
