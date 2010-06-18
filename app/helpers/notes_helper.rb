module NotesHelper
  def note_title note
    if note.name.blank?
      content_tag 'em', 'Untitled document'
    else
      note.name
    end
  end

  def comment_item comment
    user_link = link_to(comment.user.login, user_path(comment.user.id))
    capture_haml do
      haml_concat image_tag(comment.user.avatar.url(:small))
      haml_tag :h3, "#{user_link} said #{time_ago_in_words comment.created_at} ago"
      haml_tag :div, safe_simple_format(comment.message), :class => 'description'
    end
  end

  def notes_list notes, owner=false
    capture_haml do
      items_list_or_message(notes, 'There are no documents to display') do |note|
        haml_tag(:li, note_preview(note, owner))
      end
    end
  end

  def note_preview note, owner=false
    url = owner ? account_note_path(note) : note_path(note)
    capture_haml do
      haml_tag :h3, link_to(note_title(note), url)
      haml_tag :div, h(note.current.body.slice(0,400)), :class => 'description'
      haml_tag :div, :class => 'item-footer' do
        haml_tag :p do
          haml_concat "Created #{time_ago_in_words note.created_at} ago"
          haml_concat " | #{link_to 'edit', edit_account_note_path(note)}" if owner
        end
      end
    end
  end
end
