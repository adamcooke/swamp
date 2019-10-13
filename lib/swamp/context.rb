module Swamp
  class Context

    attr_reader :cli
    attr_accessor :options
    attr_accessor :args

    def initialize(cli)
      @cli = cli
    end

  end
end
