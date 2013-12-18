class NotesController < ApplicationController
  before_filter :login_required, :except => [:index]
  before_filter :find_note, :only => [:show, :edit, :update, :destroy]

  def index
    @user = current_user
    if @user
      @notes = current_user.notes
    else
      @notes = []
    end
  end

  def new
    @note = current_user.notes.new
  end

  def create
    @note = current_user.notes.create(params[:note])
    # @note.update_attribute 'version', Version.create(params[:note][:version].merge(:user => current_user, :note => @note))
    redirect_to note_url(@note)
  end

  def show

  end

  def delete
    @note = Note.find(params[:note_id])
  end

  def destroy
    @note.destroy
    redirect_to account_notes_url
  end

  def edit
  end

  def update
    @note.update_attributes(params[:note])
    # @note.update_attribute 'version', Version.create(params[:note][:version].merge(:user => current_user, :note => @note))
    redirect_to note_url(@note)
  end

  private
  def find_note
    @note = current_user.notes.find params[:id]
  end
end
