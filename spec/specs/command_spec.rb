require 'spec_helper'
require 'swamp/command'

describe Swamp::Command do

  subject(:cli) { Swamp::CLI.new(:testing) }
  subject(:command) { Swamp::Command.new(cli, :example) }

  context '#set_action' do
    it 'should set the action to the given block' do
      expect(command.action).to be nil
      command.set_action { true }
      expect(command.action).to be_a Proc
    end
  end

  context '#add_option' do
    it 'should add the option to the list of options' do
      command.add_option("-t", "--tag [NAME]", "Add a tag") { true }
      expect(command.options["-t"]).to be_a Hash
    end
  end

  context '#parse_options' do
    it 'should return the appropriate options hash' do
      command.add_option("-t [NAME]") { |value, opts| opts[:tag] = value }
      expect(command.parse_options(%w{ example -t Hello })[:tag]).to eq 'Hello'
    end
  end

end
