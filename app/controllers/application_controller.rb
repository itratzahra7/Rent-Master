class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  before_action :before_sign_up_path_for
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to companies_url, notice: 'You are not authorize to access this page'
  end
  def before_sign_up_path_for
       @featured_companies = Company.order("RAND()").where(:featured => true).limit(10)
  end
  def current_ability
    if admin_signed_in?
      @current_ability ||= Ability.new(current_admin)
    else
      @current_ability ||= Ability.new(current_company)
    end
end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :email, :password, :description, :phone, :logo]
  end
end
