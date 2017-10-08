class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :authenticate_user! 
  
  def user_not_authorized
    flash[:alert] = "You are not authorized for this action!"
    redirect_to(request.referrer || root_path)
  end
end
