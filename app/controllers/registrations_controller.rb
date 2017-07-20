class RegistrationsController < Devise::RegistrationsController
  

  protected

  def after_sign_up_path_for(company)
    edit_company_path(company)
    
  end
end
