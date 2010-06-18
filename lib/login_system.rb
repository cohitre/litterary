require_dependency "user"

module LoginSystem

  def login_required
    if current_user.nil?
      redirect_to "/"
    end
  end

  def authenticate(login, password)
    User.authenticate(login, password)
  end

  def current_user?
    !session['user_id'].nil?
  end

  def current_user
    @current_user ||= User.find(:first, :conditions => {:id => session['user_id']})
  end

  def current_user= user
    if user.nil?
      session['user_id'] = nil
    else
      session['user_id'] = user.id
    end
    current_user
  end
end
