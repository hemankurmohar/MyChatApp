class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username,:full_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :username,:bio,:avtar,:full_name]) ## add the attributes you want to permit
  end

end
