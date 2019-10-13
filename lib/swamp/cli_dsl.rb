require 'swamp/command'
require 'swamp/command_dsl'

module Swamp
  class CLIDSL

    def initialize(cli)
      @cli = cli
    end

    def command(name, &block)
      command = Command.new(@cli, name)
      CommandDSL.new(command).instance_eval(&block)
      @cli.add(command)
    end

  end
end
