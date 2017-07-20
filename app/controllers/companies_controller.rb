class CompaniesController < ApplicationController

  load_and_authorize_resource except:[:index, :show, :send_email]
  before_action :authenticate_user, except: [:index, :show, :send_email] 
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :get_params_for_sorting, only: [:index]

  # GET /companies
  # GET /companies.json
  def index
    @active_industries = Industry.all.where(status: "active")
    if params[:industry_id].blank?
      @companies = Company.order(params[:sort] + " " + params[:direction]).paginate(:page => params[:page], per_page: 10)
    else
      @industries = Industry.find(params[:industry_id].to_i)
      @companies = @industries.companies.order(params[:sort] + " " + params[:direction]).paginate(:page => params[:page], per_page: 10)
    end
    
    respond_to do |format|
      format.js 
      format.html 
    end
  end

  # GET /companies/1
  # GET /companies/1.json

  def show
  end

  # GET /companies/1/edit

  def edit
  	@active_industries = Industry.where(status: "active")
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json

  def update
    @active_industries = Industry.where(status: "active")
   
      @industries =  CompanyIndustry.where(:company_id => params[:id]).pluck(:industry_id)
      if params[:industries].blank? 
        binding.pry
        @industries.each do |industry|
          CompanyIndustry.destroy(CompanyIndustry.where("company_id = #{params[:id]}").pluck(:id))
        end
      else
        params[:industries].each do |industry| 
          unless @industries.include?(industry.to_i) 
            @industry_company = CompanyIndustry.create(:company_id => params[:id], :industry_id => industry) 
          end 
      end

      @industry_ids = params[:industries].map { |i| i.to_i }
      @industries.each do |industry|
        unless @industry_ids.include?(industry)
        CompanyIndustry.destroy(CompanyIndustry.where("company_id = #{params[:id]} and industry_id = #{industry}").pluck(:id))
        end
      end
    end
    unless params[:images].blank?
     params[:images].each do |image|
     	@products = @company.products.create(:product_image => image)
     end
   end
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end
  
  # DELETE /companies/1
  # DELETE /comapnies/1.json

  def destroy
    Company.find(params[:id].to_i).delete
    respond_to do |format|
      format.html { redirect_to companies_url }
    end
  end

  def featured_companies
    @featured_companies = Company.where(:featured => true).limit(10)
  end

  def send_email
    @company = Company.select(:email).find(params[:id].to_i)
    @user_name = params[:user_name]
    @user_email = params[:user_email]
    @user_question = params[:user_question]
    CompanyMailer.contact_email(@company, @user_email, @user_name, @user_question).deliver
  end

  private
   # Use callbacks to share common setup or constraints between actions.
    def authenticate_user
      if !company_signed_in? && !admin_signed_in?
        authenticate_company!
      end
    end
    def set_company
      @company = Company.find(params[:id])
    end
   # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      if params[:direction].nil?
        params[:direction] = "asc"
      end
      if params[:sort].nil?
        params[:sort] = "name"
      end
      params.require(:company).permit(:name, :description, :phone, :industries, :images, :featured, :logo, :industry_id, :direction, :user_email, :sort)
    end
    def get_params_for_sorting
      if params[:direction].nil?
        params[:direction] = "asc"
      end
      if params[:sort].nil?
        params[:sort] = "name"
      end
    end
end
