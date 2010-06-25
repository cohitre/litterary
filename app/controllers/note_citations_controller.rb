class NoteCitationsController < ApplicationController
  before_filter :find_note
  def new
    render :layout => false if request.xhr?
  end

  def create
    @note.current.citations.create(params[:citation].merge({:user => current_user}))
    redirect_to note_url(@note)
  end

  private
  def find_note
    @note = Note.find(params[:note_id])
  end
end
