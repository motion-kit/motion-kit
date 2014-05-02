# coding: utf-8

module DBT
  module_function
  def analyze(app)
    debugger_cmds_output = ''
    dependers = Hash.new { |hash,key| hash[key] = [] }
    providers = {}
    default_providers = {}

    files = app.files.flatten.uniq
    files.flatten.each do |filename|
      File.open(filename, 'r') do |file|
        file.each_line do |line|
          command = false

          if line =~ /^#--+>/
            command, dep = line.rstrip.sub(/^#--+> */, '').split(' ', 2)
          elsif line =~ /^[ \t]*#[ \t]*@(provides|requires)/
            command, dep = line.rstrip.sub(/^[ \t]*#[ \t]*@/, '').split(' ', 2)
          end

          if command
            case command
            when 'break'
              dep ||= file.lineno + 1
              debugger_cmds_output += "breakpoint set --file #{File.basename filename} --line #{dep}\n"
            when 'provides'
              if providers.key? dep
                puts "\033[1m!HAY DEMASIADOS!\033[0m \033[1;31m#{dep}\033[0m"
              end
              providers[dep] = filename
            when 'requires'
              dependers[filename] << dep
            else
              puts "\033[1m!NO COMPRENDO!\033[0m \"#{command} #{dep}\""
              puts "\033[1;31m#{filename}:#{file.lineno}\033[0m"
            end
          elsif line =~ /^[ \t]*class[ \t]+(\w+)/
            dep = "class:#{$1}"
            default_providers[dep] = filename
          elsif line =~ /^[ \t]*module[ \t]+(\w+)/
            dep = "module:#{$1}"
            default_providers[dep] = filename
          end
        end
      end
    end # files

    default_providers.each do |dep, filename|
      providers[dep] ||= filename
    end

    dependers.each do |filename, dependencies|
      if dep = dependencies.find { |dep| ! providers.include? dep }
        puts "\033[1m!NO HAY!\033[0m \033[1;31m#{dep}\033[0m"
        raise "#{filename} could not find a provider for #{dep}"
      else
        app.files_dependencies filename => dependencies.map { |dep| providers[dep] }
      end
    end

    unless debugger_cmds_output.empty?
      File.open('debugger_cmds', 'w') do |file|
        file.write "#------> Creado por el DBT <------#\n"
        file.write debugger_cmds_output
      end
    end
  end
end


Motion::Project::App.setup do |app|
  def app.analyze
    puts("\033[1mcalling `app.analyze` is deprecated.  Use DBT.analyze(app) instead (non-polluting)\033[0m")
    DBT.analyze(self)
  end
end
