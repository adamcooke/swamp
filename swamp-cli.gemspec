require_relative './lib/swamp/version'
Gem::Specification.new do |s|
  s.name          = "swamp-cli"
  s.description   = %q{A framework for writing simple CLI applications in Ruby.}
  s.summary       = %q{Used by Procodile and Bask, this is a simple framework for developing simple CLI applications in Ruby.}
  s.homepage      = "https://github.com/adamcooke/swamp"
  s.version       = Swamp::VERSION
  s.files         = Dir.glob("lib/**/*")
  s.require_paths = ["lib"]
  s.authors       = ["Adam Cooke"]
  s.email         = ["me@adamcooke.io"]
  s.licenses      = ['MIT']
  s.cert_chain    = ['certs/adamcooke.pem']
  s.signing_key   = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/
end
