class NotesIndexItemStencil < Stencil::Base
  needs :note
  template "notes_index_item_stencil"

  def href
    url_helpers = Rails.application.routes.url_helpers
    url_helpers.note_path(@note)
  end

  def title?
    @note.name?
  end

  def title
    @note.name
  end
end
