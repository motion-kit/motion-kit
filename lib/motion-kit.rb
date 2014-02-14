require 'motion-require'

Motion::Require.all(Dir.glob(File.expand_path('../motion-kit/**/*.rb', __FILE__)))
