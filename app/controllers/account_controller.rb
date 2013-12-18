class AccountController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def create
    @user = User.new
    @user.login    = params['user']['login']
    @user.password = params['user']['password']
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.save

    if @user.errors.empty?
      self.current_user = @user
      redirect_to account_path
    else
      render :action => :new
    end
  end

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
