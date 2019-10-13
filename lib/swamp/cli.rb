require 'swamp/version'
require 'swamp/command'
require 'swamp/command_dsl'
require 'swamp/cli_dsl'
require 'swamp/context'
require 'swamp/error'

module Swamp
  class CLI

    attr_reader :commands
    attr_reader :app_name
    attr_accessor :version

    def initialize(app_name, options = {})
      @app_name = app_name
      @version = options[:version]
      @commands = {}
    end

    def add(command)
      @commands[command.name.to_sym] = command
    end

    def command(name)
      @commands[name.to_sym]
    end

    def dispatch(argv, *additional_args)
      command_name = argv.shift
      if command_name && command = command(command_name)
        context = Context.new(self)
        context.options = command.parse_options(argv)
        context.args = argv

        command.action.call(context, *additional_args)
      else
        raise Error, "Command not found"
      end
    end

    def load_from_directory(path)
      unless File.directory?(path)
        raise Error, "No commands directory at #{path}"
      end

      Dir[File.join(path, '**', '*.rb')].each do |path|
        CLIDSL.new(self).instance_eval(File.read(path))
      end
    end

  end
end
