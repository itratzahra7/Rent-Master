class CompaniesController < ApplicationController

  before_action :authenticate_user, except: [:index, :show, :send_email]
  load_and_authorize_resource
  # skip authenticate on this action
  #before_action :authenticate_company!
  before_action :get_params_for_sorting, only: [:index]

  # GET /companies
  # GET /companies.json

  # discuss again index action cancan
  def index
    @active_industries = Industry.all.where(status: "active")
    if params[:industry_id].blank?
      @companies = @companies.order(params[:sort] + " " + params[:direction]).paginate(page: params[:page], per_page: 10)
    else
      @companies = @companies.joins(:industries).where("company_industries.industry_id"  => params[:industry_id]).order(params[:sort] + " " + params[:direction]).paginate(:page => params[:page], per_page: 10)
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
# class methods vs namescope

#use namescopes in edit
  def edit
  	@active_industries = Industry.where(status: "active")
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json

  def update
    @active_industries = Industry.where(status: "active")
    @industries =  CompanyIndustry.where(company_id: params[:id]).pluck(:industry_id)
    if params[:industries].blank? 
      @company.company_industries.destroy_all
    else
      params[:industries].each do |industry| 
      unless @industries.include?(industry.to_i) 
        @industry_company = CompanyIndustry.create(company_id: params[:id], industry_id: industry) 
      end 
    end

      @industry_ids = params[:industries].map { |i| i.to_i }
      @industries.each do |industry|
        unless @industry_ids.include?(industry)
          @company.company_industries.where(industry_id: industry).delete_all
         # @company.company_industries.destroy(industry_id: industry)
        # CompanyIndustry.destroy(CompanyIndustry.where("company_id = #{params[:id]} and industry_id = #{industry}").pluck(:id))
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

#delete by association

  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url }
    end
  end
# new syntax hash and association
# remove instance variables
  def send_email
    CompanyMailer.contact_email(@company, params[:user_email], params[:user_name], params[:user_question]).deliver
    respond_to do |format|
      format.html { render action: 'show' }
    end 
  end

  private
   # Use callbacks to share common setup or constraints between actions.
   # check again authenticate 

   #move it to the application controller
    def authenticate_user
      if !company_signed_in? && !admin_signed_in?
        authenticate_company!
      end
    end

   # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      if params[:direction].blank?
        params[:direction] = "asc"
      end
      if params[:sort].blank?
        params[:sort] = "name"
      end
      params.require(:company).permit(:name, :description, :phone, :industries, :images, :featured, :logo, :industry_id, :direction, :user_email, :sort)
    end
    #blank
    def get_params_for_sorting
      if params[:direction].blank?
        params[:direction] = "asc"
      end
      if params[:sort].blank?
        params[:sort] = "name"
      end
    end
end
