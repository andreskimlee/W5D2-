class ApplicationController < ActionController::Base
helper_method :logged_in?, :current_user

def current_user
  @current ||= User.find_by(session_token: session[:session_token])
end 

def ensure_logged_in 
  redirect_to new_session_url unless logged_in? 
end 

def login(user)
  session[:session_token] = user.reset_session_token! 
end 

def logout
  current_user.reset_session_token!
  @current_user = nil 
  session[:session_token] = nil 
end 

def logged_in?
  !!current_user
end

def is_moderator?
  self.moderator_id == current_user.id
end

end
