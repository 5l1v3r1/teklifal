class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery
  after_action :verify_authorized, except: :index, unless: :devise_controller?
  # after_action :verify_policy_scoped, only: :index

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    keys = [:first_name, :last_name, :phone, :avatar, :remove_avatar, :signed_in_from_new_announcement]

    devise_parameter_sanitizer.permit(:sign_in, keys: [:signed_in_from_new_announcement])
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end


  helper_method :anonymous_user?
  def anonymous_user?
    !user_signed_in?
  end
end
