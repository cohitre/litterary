# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def breadcrumb *args
    return args.join(h(" > "))
  end

  def items_list_or_message(items, message, &block)
    if items.empty?
      result = content_tag("p", message, :class => 'default-message')
    else
      result = capture_haml do
        haml_tag :ul, :class => 'items-list' do
          items.each {|item| block.call(item)}
        end
      end
    end
    haml_concat result
  end

  def safe_simple_format text
    simple_format h(text)
  end
end
