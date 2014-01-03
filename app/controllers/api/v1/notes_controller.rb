class Api::V1::NotesController < ApplicationController
  def show
    @note = Note.find params[:note_id]
    render json: @note.to_json
  end

  def draft
    @note = current_user.draft
    render json: @note.to_json
  end

  def update
    @note = current_user.draft
    @note.attributes = params[:note]
    @note.save!
    render json: @note.to_json
  end

  def create_citation
    @note = Note.find params[:note_id]
    citation_hash = {
      message: params[:citation][:comment],
      range_begin: params[:citation][:range][:start],
      range_end: params[:citation][:range][:end],
      user: current_user
    }
    citation = @note.citations.create(citation_hash)
    render json: citation.to_json
  end
end
