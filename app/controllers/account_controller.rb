class AccountController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user
    @notes = @user.notes.find(:all , :order => 'created_at DESC' , :limit => 5 )
  end

  def edit
    @user = current_user
  end

  def update
    current_user.update_attributes(params['user'])
    if current_user.errors.empty?
      redirect_to account_path
    else
      @user = current_user
      render :action => 'edit'
    end
  end
end
