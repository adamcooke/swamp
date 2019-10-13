require 'optparse'

module Swamp
  class Command

    attr_reader :name
    attr_reader :options
    attr_reader :action
    attr_accessor :description

    def initialize(cli, name)
      @cli = cli
      @name = name
      @options = {}
      @args = []
    end

    def set_action(&block)
      @action = block
    end

    def add_option(command, *args, &block)
      @options[command] = {spec: [command] + args, block: block}
    end

    def parse_options(argv)
      options = {}
      OptionParser.new do |opts|
        opts.version = @cli.version
        opts.banner = "Usage: #{@cli.app_name} #{@name} [options]"
        @options.values.each do |option|
          opts_block = proc { |value| option[:block].call(value, options) }
          opts.on(*option[:spec], &opts_block)
        end
      end.parse!(argv)
      options
    rescue OptionParser::InvalidOption, OptionParser::MissingArgument => e
      raise Swamp::Error, e.message
    end

  end
end
