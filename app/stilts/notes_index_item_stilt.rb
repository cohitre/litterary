class NotesIndexItemStilt < Stilts::Base
  needs :note
  template :haml, "app/stilts/notes_index_item_stilt.html.haml"

  def href
    url_helpers.note_path(@note)
  end

  def title
    @note.name
  end
end
