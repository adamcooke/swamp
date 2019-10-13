command :command2 do
  desc "Some other description"
  option "-t [VALUE]" do |value, opts|
    opts[:t] = value
  end
  action do
    true
  end
end
