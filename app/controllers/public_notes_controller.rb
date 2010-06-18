class PublicNotesController < ApplicationController
  def index
    @notes = Note.all
  end
  
  def show
    @note = Note.find(params[:id])
  end
end
