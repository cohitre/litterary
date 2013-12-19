class NotesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  before_filter :find_note, :only => [:show, :edit, :update, :destroy]

  def index
    @notes = Note.all
  end

  def new
    @note = current_user.notes.new
  end

  def create
    @note = current_user.notes.create(params[:note])
    redirect_to note_url(@note)
  end

  def delete
    @note = Note.find(params[:note_id])
  end

  def destroy
    @note.destroy
    redirect_to notes_url
  end

  def edit
  end

  def update
    @note.update_attributes!(params[:note])
    redirect_to note_url(@note)
  end

  private

  def find_note
    @note = current_user.notes.find params[:id]
  end
end
