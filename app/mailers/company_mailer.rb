class CompanyMailer < ActionMailer::Base
  default from: "from@example.com"
  def contact_email(company, user_email, user_name, user_question)
    @company = company
    @user_email = user_email
    @user_name = user_name
    @user_question = user_question
    mail(from: @user_email, to: @company.email, subject: 'Rent Product')
  end
end
