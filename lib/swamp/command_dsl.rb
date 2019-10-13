module Swamp
  class CommandDSL

    def initialize(command)
      @command = command
    end

    def action(&block)
      @command.set_action(&block)
    end

    def option(*args, &block)
      @command.add_option(*args, &block)
    end

    def desc(text)
      @command.description = text
    end

  end
end
