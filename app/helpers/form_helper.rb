module FormHelper
  def self.included(base)
    ActionView::Base.default_form_builder = LitteraryFormBuilder
  end

  class LitteraryFormBuilder < ActionView::Helpers::FormBuilder
    def labeled_field(field, method, options={})
      l = options.delete :label
      c = "#{label(method, l)} #{send(field, method, options)}".html_safe
      @template.content_tag('div', c, :class => "input-field input-#{field}".gsub("_","-")).html_safe
    end

    def label_text_area(method, options={})
      labeled_field(:text_area, method, options)
    end

    def label_text(method, options={})
      labeled_field(:text_field, method, options)
    end

    def label_password(method, options={})
      labeled_field(:password_field, method, options)
    end

    def label_file(method, options={})
      labeled_field(:file_field, method, options)
    end

    def label_check_box(method, options={})
      l = options.delete :label
      c = "#{check_box(method, options)} #{label(method, l)}".html_safe
      @template.content_tag('div', c, :class => "input-field input-check-box".gsub("_","-")).html_safe
    end

    def save(l)
      self.submit(l, class: "btn btn-primary")
    end
  end
end
