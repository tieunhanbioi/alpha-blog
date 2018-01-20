class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  # in order to make the methods available in the views , we need to declare them in the helper method
  helper_method :current_user, :logged_in?

# this method will return an integer , like 14 or whatever is in the session[:user_id] variable
# this method stores the current logged in user into a variable
  def current_user
    # a = nil
    # b = 20
    # a ||= b   ========================> a = a || b
    # @current_user = @current_user || User.find(session[:user_id] if sesssion[:user_id])
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # !! == convert anything to a boolean
  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
  end
end
end
