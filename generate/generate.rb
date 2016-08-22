# This file auto generates my entire website.
require 'redcarpet'
require 'htmlbeautifier'
require 'pathname'
require 'erb'
require 'yaml'

$LOAD_PATH.unshift(File.expand_path('../', __FILE__))
require 'index/index'
require 'fancy'

@contact = File.read(File.expand_path('../general/contact.html', __FILE__))
@footer = ERB.new(File.read(File.expand_path('../general/footer.html.erb', __FILE__))).result()
@head = File.read(File.expand_path('../general/head.html', __FILE__))


prepare_entires
write_index_html
