class NoteCitationsController < ApplicationController
  before_filter :find_note
  def new
    render :layout => false if request.xhr?
  end

  def create
    citation_hash = {
      message: params[:citation][:comment],
      range_begin: params[:citation][:range][:start],
      range_end: params[:citation][:range][:end],
      user: current_user
    }
    citation = @note.current.citations.create(citation_hash)
    render json: citation.to_json
  end

  private
  def find_note
    @note = Note.find(params[:note_id])
  end
end
