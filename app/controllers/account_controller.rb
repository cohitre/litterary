class AccountController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user
    @weeks = @user.weeks.order("created_at DESC")
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
