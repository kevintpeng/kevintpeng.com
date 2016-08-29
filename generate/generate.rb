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

begin
  prepare_entires
  prepare_index
  write_index_html
  write_resume
rescue Exception => e
  case e
  when nil         # normal, non-error termination
  when Interrupt   # ctrl-c
    Fancy.error "Interrupt. Changes not committed."
  else
    Fancy.error "Error Ocurred. Changes not committed."
  end
  raise e
end
