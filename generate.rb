require 'redcarpet'
require 'pathname'
require 'erb'
require 'yaml'
require './generate/index'

@entries = Index.generate_entries
sections = ['Work Experience', 'Projects', 'Awards']
index = ''
sections.each do |section|
  index << "<h1>#{section}</h1>\n"
  @entries[section].each_reverse do |entry|
    index << "#{entry}\n"
  end
@body = index
@contact = File.read('contact.html')
@footer = ERB.new('footer.html.erb').result()

index_template = ERB.new('index.html.erb')
