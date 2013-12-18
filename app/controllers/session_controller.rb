class SessionController < ApplicationController
  def create
    self.current_user = User.authenticate(params[:user][:login], params[:user][:password])

    if current_user?
      flash['notice'] = "Login successful"
      redirect_to account_path
    else
      flash['notice'] = "Login unsuccessful"
      redirect_to login_path
    end
  end

  def destroy
    session['user_id'] = nil
    redirect_to "/"
  end
end
