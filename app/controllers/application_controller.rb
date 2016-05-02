class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  http_basic_authenticate_with name: "shore@51$", password: "razor+21$"

# def authenticate_user!
#  if user_signed_in?
#    redirect_to :controller=>'home', :action => 'index'
#   else
#    render '/devise/registrations/new.html.erb'
#   end
# end


# def after_sign_in_path_for(resource)
#     Rails.logger.info "D"*100
#     redirect_to root_url
    # sign_in_url = new_user_session_url
    # if request.referer == sign_in_url
    #   super
    # else
    #   stored_location_for(resource) || request.referer || root_path
    # end
  # end
# end

def after_sign_in_path_for(resource)
  request.env['omniauth.origin'] || stored_location_for(resource) || root_path
end




end
