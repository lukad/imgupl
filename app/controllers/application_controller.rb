class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  check_authorization unless: :skip_authorization?

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def authenticate_admin_user!
    unless current_user
      redirect_to new_user_session_path
      return
    end
    redirect_to root_path unless current_user.admin?
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :current_password) }
  end

  def activeadmin_resource?
    self.class.ancestors.include? ActiveAdmin::BaseController
  end

  def skip_authorization?
    devise_controller? || activeadmin_resource?
  end
end
