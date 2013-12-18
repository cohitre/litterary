class UserController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.find :all
  end

  def show
    @user = User.find_by_login(params[:id])
    if @user.nil?
      raise ActionController::RoutingError.new('Not Found')

    end
  end
end
