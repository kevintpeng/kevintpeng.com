module Fancy
  def self.puts(output)
    STDOUT.puts "\x1b[32m✓\x1b[0m #{output}"
  end
end
