class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(company)
    company_path(company)
  end
end
