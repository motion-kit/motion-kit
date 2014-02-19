require 'motion-require'

Motion::Require.all(Dir.glob(File.expand_path('../motion-kit/**/*.rb', __FILE__)))
Motion::Require.all(Dir.glob(File.expand_path('../motion-kit-ios/**/*.rb', __FILE__)))
