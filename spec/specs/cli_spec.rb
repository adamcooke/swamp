require 'spec_helper'
require 'swamp/cli'
require 'swamp/command'

describe Swamp::CLI do

  subject(:cli) { Swamp::CLI.new(:testing) }

  context '#add' do
    it 'should add commands to the CLI' do
      command = Swamp::Command.new(cli, :help)
      cli.add(command)
      expect(cli.commands[:help]).to eq command
    end
  end

  context '#command' do
    it 'should return a command if one exists' do
      command = Swamp::Command.new(cli, :help)
      cli.add(command)
      expect(cli.command(:help)).to eq command
    end

    it 'should return nil if no command exists with the given name' do
      expect(cli.command(:another)).to be nil
    end
  end

  context '#dispatch' do
    subject(:command) { Swamp::Command.new(cli, :example) }
    before(:each) { cli.add(command) }

    it 'should call the dispatch method on the given command' do
      run = false
      command.set_action { run = true }
      cli.dispatch(%w{ example })
      expect(run).to be true
    end

    it 'should provide the options in the context' do
      command.set_action do |context|
        expect(context).to be_a Swamp::Context
        expect(context.options[:w]).to eq 'provided'
      end
      command.add_option("-w") { |value, options| options[:w] = "provided" }
      cli.dispatch(%w{ example -w })
    end

    it 'should provide the args in the context' do
      command.set_action do |context|
        expect(context).to be_a Swamp::Context
        expect(context.args[0]).to eq 'arg1'
        expect(context.args[1]).to eq 'arg2'
        expect(context.args[2]).to eq 'arg3'
      end
      cli.dispatch(%w{ example arg1 arg2 arg3 })
    end
  end

  context '#load_from_directory' do
    it 'should add commands found in any .rb file in the directory' do
      cli.load_from_directory(File.join(SPEC_ROOT, 'example-dir'))
      expect(cli.commands[:command1]).to be_a Swamp::Command
      expect(cli.commands[:command2]).to be_a Swamp::Command
    end
  end

end
