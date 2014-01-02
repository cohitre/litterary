module Stilts
  class Base
    def self.needs(*keys)
      @keys = keys
    end

    def self.template(type, file)
      @template_type = type
      @template_file = file
    end

    def self.template_file
      @template_file
    end

    def self.template_type
      @template_type
    end

    def initialize(options={})
      options.each_pair do |k, v|
        self.instance_variable_set "@#{k}", v
      end
      @options = options
    end

    def url_helpers
      Rails.application.routes.url_helpers
    end

    def to_html
      file = File.open(self.class.template_file).read
      if self.class.template_type == :haml
        Haml::Engine.new(file).render(self)
      end
    end
  end
end
