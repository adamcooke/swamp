# Swamp

Swamp is a simple framework for developing command line applications in Ruby.

## Getting Started

Swamp works by allowing you to define a commands in a directory of your application. These commands can then be executed when needed and options provided as needed.

To begin, just make a directory in your application and define your first command using the simple command DSL. Here's an example:

```ruby
command :install do
  desc "Install an application"

  option "-f", "--force" do |value, opts|
    opts[:force] = true
  end

  action do |context|
    if context.args[0].nil?
      raise Error, "You must provide a command."
    end

    if context.options[:force]
      # We can look at the options if we want...
    end

    # ... continue with the rest of your method.
  end
end
```

Once you've defined your commands, you'll need to create an entry point for your application. Usually this is a file in the `bin` folder of your application. You'll usually want to require other parts of your application but the boiler plate required to dispatch actions to your Swamp defined commands is as follows:

```ruby
require 'swamp/cli'

begin
  cli = Swamp::CLI.new(:bask, version: Bask::VERSION)
  cli.load_from_directory(File.expand_path('../../commands', __FILE__))
  cli.dispatch(ARGV)
rescue Swamp::Error => e
  $stderr.puts "Error: #{e.message}"
  exit 1
end
```

That's about it really.
