command :command1 do
  desc "Some description"
  option "-w" do |value, opts|
    opts[:w] = true
  end
  action do
    true
  end
end
