# This file auto generates my entire website.
require 'redcarpet'
require 'htmlbeautifier'
require 'pathname'
require 'erb'
require 'yaml'

require './generate/fancy'
require './generate/entries'
require './generate/index'

@contact = File.read('./generate/_contact.html')
@footer = ERB.new(File.read('./generate/footer.html.erb')).result()
@head = File.read('./generate/_head.html')

prepare_entires
write_index_html
