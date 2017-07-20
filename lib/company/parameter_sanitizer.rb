class Company::ParameterSanitizer < Devise::ParameterSanitizer
  def sign_up
    default_params.permit(:name, :email, :password, :password_confirmation, :description, :phone, :logo)
  end
  def sign_in
    default_params.permit(:email, :password)
  end
end