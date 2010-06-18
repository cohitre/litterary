class NoteCommentsController < ApplicationController
  before_filter :find_note
  def create
    @note.comments.create(params[:comment].merge({:user => current_user}))
    redirect_to note_url(@note)
  end
  
  private
  def find_note
    @note = Note.find(params[:note_id])
  end
end
