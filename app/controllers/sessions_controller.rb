#session controller ,would be more appropriate if name login controller
class SessionsController < ApplicationController
  def new
  end


 #the create method is the one which checks the credential provide by the login form against those of the database
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
       session[:user_id] = curent_user()
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
      # puts session[:user_id]
      # render plain: session[:user_id]
      #   debugger
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
  end
end

  def destroy
     session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end
