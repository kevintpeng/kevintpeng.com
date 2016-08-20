# This file auto generates my entire website.
require 'redcarpet'
require 'htmlbeautifier'
require 'pathname'
require 'erb'
require 'yaml'

require './generate/entries'
require './generate/index'

prepare_entires
write_index_html
