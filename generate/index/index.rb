require 'index/entries'

# entries are any work experiences, projects or awards.
# generates and orders html for each entry,
# returns a hash of {<section>: <list of entry html>}
def prepare_entires
  @entries = Entries.generate
  @entries.each do |section, entries|
    @entry_template ||= File.read(File.expand_path('../entry.html.erb', __FILE__))
    @entry_renderer ||= ERB.new(@entry_template)
    @entries[section] = entries.map do |entry|
      # render each entry
      @entry = entry
      @entry_renderer.result() if @entry
    end
  end
  Fancy.puts 'All Entries are rendered.'
end

def write_resume
  sections = ['Work Experience', 'Projects', 'Awards']
end

def prepare_index
  sections = ['Work Experience', 'Projects', 'Awards']
  body = ''
  sections.each do |section|
    body << "<h1>#{section}</h1>\n"
    (@entries[section] || []).reverse_each do |entry|
      body << "#{entry}\n" if entry
    end
  end
  @body = body
end

def write_index_html(file = "index.html.erb")
  name = file[/^[^\.]*/]
  template = ERB.new(File.read(File.expand_path("../#{file}", __FILE__)))
  result = template.result()
  # indents and cleans html output
  result = HtmlBeautifier.beautify(result)
  Fancy.puts "#{name} successfully generated."
  File.open("#{name}.html", 'w') { |f| f.write(result)}
end
