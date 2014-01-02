class Api::V1::NotesController < ApplicationController
  def show
    @note = Note.find params[:note_id]
    render json: {
      body: @note.body.gsub(/\r/," "),
      citations: @note.draft.citations.map(&:to_json)
    }
  end
end
