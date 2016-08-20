module Fancy
  def self.puts(output)
    STDOUT.puts "\x1b[1;32m✓\x1b[0;1m #{output}\x1b[0m"
  end
end
