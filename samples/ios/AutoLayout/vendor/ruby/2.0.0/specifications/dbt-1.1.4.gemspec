# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "dbt"
  s.version = "1.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Colin Thomas-Arnold <colinta@gmail.com>"]
  s.date = "2014-04-30"
  s.description = "== DBT (Dependencies and deBugging Tool)\n\nDBT is a tool that helps declare dependencies (+app.files_dependencies+) and\nassists with debugging in a RubyMotion project. It looks for 'break',\n'requires', and 'provides' commands (it does a *teensy* bit of code analyzing to\nprovide some defaults) to make your RubyMotion +Rakefile+ and +debugger_cmds+\nfiles short and consistent.\n\nTo use, include this gem, and add +DBT.analyze(app)+ to your +Rakefile+ in the\n<tt>Motion::Project::App.setup</tt> block.  In your source code you can add DBT\ncommands and those will be translated into directives for\n+app.files_dependencies+ and +debugger_cmds+.\n\nRun +rake+ or <tt>rake debug=1</tt>, and off you go!\n"
  s.email = ["colinta@gmail.com"]
  s.homepage = "https://github.com/colinta/dbt"
  s.licenses = ["BSD"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Keep your Rakefile and debugger_cmds files short and consistent"
end
