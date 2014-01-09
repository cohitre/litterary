class NotesIndexItemStencil < Stencil::Base
  needs :note
  template "app/stencils/notes_index_item_stencil.html.haml"

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
