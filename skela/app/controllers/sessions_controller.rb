class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to welcome_path
    end
  end

  def create
    if logged_in?
      session[:user_id] = nil
    end
    user = User.find_by_username params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    session[:user_id] = nil

    respond_to do |format|
      format.js
    end
  end
end
