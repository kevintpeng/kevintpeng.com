# Logic behind generating the index page
module Entries
  class << self
    def generate
      puts "generating"
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
      entries = {}
      Dir.glob('./entries/*.yml') do |file|
        entry_yml = YAML.load_file(file)
        section = entry_yml['section']
        entries[section] ||= []
        entries[section][entry_yml['index']] = parse_yml(entry_yml, markdown)
      end
      entries
    end

    private

    # EXAMPLE:
    # index: 3
    # section: Work Experience
    # title: Production Engineering Intern
    # tech: (optional)
    #   - ruby
    #   - nginx
    # year: 2016 (optional)
    # company: Name
    # place: Ottawa, Canada (optional)
    # time: May 2016 - August 2016 (optional)
    # desc: *any* markdown
    # buttons:
    #   - glyphicon: link (optional)
    #     devicon: ruby (optional/alternative)
    #     text: Published Article on Shopify Engineering Blog
    #     link: https://engineering.shopify.com/

    def parse_yml(yml, markdown)
      yml['tech'].map! { |t| t.include?('-') ? "devicon devicon-#{t}" : "devicon devicon-#{t}-plain-wordmark" }
      yml['buttons'].map! { |hash| render_button(hash) }
      yml['desc'] = markdown.render yml['desc']
      yml
    end

    def render_button(button_hash)
      button = "<a class=\"btn btn-primary btn-lg\" href=\"#{button_hash['link']}\">"
      icon = "<span class=\"glyphicon glyphicon-#{button_hash['glyphicon']}\"></span>" if button_hash['glyphicon']
      icon = "<span class=\"devicon devicon-#{button_hash['devicon']}-plain\"></span>" if button_hash['devicon']
      icon ||= ""
      button = "#{button}#{icon} #{button_hash['text']}</a>"
    end
  end
end
