class NotesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  before_filter :find_note, :only => [:update, :destroy, :delete]

  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = current_user.notes.new
    @note.build_version
  end

  def create
    if current_user.draft?
      @note = current_user.draft
    else
      @note = current_user.build_draft
    end
    @note.attributes = params[:note]
    @note.save!
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
