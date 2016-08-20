# This file auto generates my entire website.
require 'redcarpet'
require 'htmlbeautifier'
require 'pathname'
require 'erb'
require 'yaml'

require './generate/index'

# entries are any work experiences, projects or awards
@entries = Index.generate_entries
@entries.each do |section, entries|
  @entry_template ||= File.read('entry.html.erb')
  @entry_renderer ||= ERB.new(@entry_template)
  @entries[section] = entries.map do |entry|
    # render each entry
    @entry = entry
    @entry_renderer.result() if @entry
  end
end

sections = ['Work Experience', 'Projects', 'Awards']
index = ''
puts @entries
sections.each do |section|
  index << "<h1>#{section}</h1>\n"
  (@entries[section] || []).reverse_each do |entry|
    index << "#{entry}\n" if entry
  end
end
@body = index
@contact = File.read('contact.html')
@footer = ERB.new(File.read('footer.html.erb')).result()

index_template = ERB.new(File.read('index.html.erb'))
index = index_template.result()
index = HtmlBeautifier.beautify(index)

File.open("index.html", 'w') { |f| f.write(index)}
