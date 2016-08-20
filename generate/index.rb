module Index
  class << self
    attr_reader :entries
    def generate_entries
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
      entries = {}
      Dir.glob('../entries/*.yml') do |file|
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
      yml['tech'].map! { |t| "devicon devicon-#{t}-plain" }
      yml['buttons'].map! { |hash| render_button(hash, markdown) }
      yml['desc'] = markdown.render yml['desc']
      @entry_template ||= File.read('entry.html.erb')
      @entry_renderer ||= ERB.new(@entry_template)
      @entry = yml
      @entry_renderer.result()
    end

    def render_button(button_hash, markdown)
      button = "<a class=\"btn btn-primary btn-lg\" href=\"#{button_hash['link']}\">"
      icon = "<span class=\"glyphicon glyphicon-#{button_hash['glyphicon']}\"></span>" if button_hash['glyphicon']
      icon = "<span class=\"devicon devicon-#{button_hash['glyphicon']}-plain\"></span>" if button_hash['devicon']
      icon ||= ""
      button = "#{button}#{icon} #{markdown.render(button_hash['text'])}</a>"
    end
  end
end
