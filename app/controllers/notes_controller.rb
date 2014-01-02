class NotesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_note, :only => [:update, :destroy, :delete]

  def show
    @note = Note.find(params[:id])
  end

  def index
    @notes = Note.all
  end

  def new
    @note = current_user.notes.new
    @note.build_version
  end

  def create
    @note = current_user.notes.create(params[:note])
    redirect_to note_url(@note)
  end

  def destroy
    @note.destroy
    redirect_to notes_url
  end

  def edit
    @note = current_user.draft || current_user.build_draft
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
