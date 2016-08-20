# entries are any work experiences, projects or awards.
# generates and orders html for each entry,
# returns a hash of {<section>: <list of entry html>}
def prepare_entires
  @entries = Entries.generate
  @entries.each do |section, entries|
    @entry_template ||= File.read('entry.html.erb')
    @entry_renderer ||= ERB.new(@entry_template)
    @entries[section] = entries.map do |entry|
      # render each entry
      @entry = entry
      @entry_renderer.result() if @entry
    end
  end
  Fancy.puts 'All Entries are rendered.'
end

def write_index_html
  sections = ['Work Experience', 'Projects', 'Awards']
  index = ''
  sections.each do |section|
    index << "<h1>#{section}</h1>\n"
    (@entries[section] || []).reverse_each do |entry|
      index << "#{entry}\n" if entry
    end
  end
  # these three values are used in the index template
  @body = index
  @contact = File.read('contact.html')
  @footer = ERB.new(File.read('footer.html.erb')).result()

  index_template = ERB.new(File.read('index.html.erb'))
  index = index_template.result()
  # indents and cleans html output
  index = HtmlBeautifier.beautify(index)
  Fancy.puts 'Index Successfully Generated.'
  File.open("index.html", 'w') { |f| f.write(index)}
end
