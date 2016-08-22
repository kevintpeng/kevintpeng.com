# Logic behind generating the index page
module Entries
  class << self
    def generate
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
      entries = {}
      Dir.glob('..//entries/**/*.yml') do |file|
        entry_yml = YAML.load_file(file)
        section = entry_yml['section']
        entries[section] ||= []
        parsed = parse_yml(entry_yml, markdown)
        entries[section][entry_yml['index']] = parsed unless parsed['deprecated'] || parsed['disabled']
      end
      Fancy.puts "All yml files for entries were successfully parsed."
      entries
    end

    private

    # EXAMPLE:
    # disabled: false
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
      yml['tech'].map! { |t| t.include?('-') ? "devicon devicon-#{t}" : "devicon devicon-#{t}-plain-wordmark" } if yml['tech']
      yml['buttons'].map! { |hash| render_button(hash) } if yml['buttons']
      yml['desc'] = markdown.render(yml['desc']) if yml['desc']
      yml
    end

    def render_button(button_hash)
      # generates the button itself
      button = "<a class=\"btn btn-primary btn-lg\" href=\"#{button_hash['link']}\">"
      # resolve icon
      icon = "<span class=\"glyphicon glyphicon-#{button_hash['glyphicon']}\"></span>" if button_hash['glyphicon']
      icon = "<span class=\"devicon devicon-#{button_hash['devicon']}-plain\"></span>" if button_hash['devicon']
      # renders contents of the button
      button = "#{button}#{icon} #{button_hash['text']}</a>"
    end
  end
end
