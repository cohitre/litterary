module NoteCommentsHelper
  def comments_list items
    capture_haml do
      items_list_or_message(items, 'There are no comments to display') do |item|
        haml_tag(:li, comment_item(item))
      end
    end
  end
end
