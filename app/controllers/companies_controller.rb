class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy, :csasses_management, :gallery, :create_up_pictures]
  before_filter :authenticate_user_admin!, except: [:show, :index]
  before_filter :authenticate_admin!, only: :csasses_management
  #before_filter :user_active!

  # GET /companies
  # GET /companies.json
  
  def gallery
    @pictures = @company.pictures
    #@company.pictures.build
    prepare_uploadify
  end
  
  def create_up_pictures
    @pic = @company.pictures.create
    @pic.update_column(:image, params[:key_param])
    
    respond_to do |format|
      if @pic.save
        format.json { render json: 'success', status: :created, location: @company }
      else
        format.json { render json: @pic.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @csasses = @company.csasses
  end

  def csasses_management
    @csasses = @company.csasses
    render 'companies/csasses/index'
  end
  
  # GET /companies/new
  def new
    @company = current_user.companies.new()
    @services = Service.all.map(&:name)
    @company.pictures.build
  end

  # GET /companies/1/edit
  def edit
    @company.pictures.build unless @company.pictures.any?
  end

  # POST /companies
  # POST /companies.json
  def create
    # unless @company.pictures.first.image_url.nil?
    @company = current_user.companies.new(company_params[:company])
    @company.pictures.build
    
    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render action: 'show', status: :created, location: @company }
      else
        format.html { render action: 'new' }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      #p company_params
      if @company.update(company_params[:company])
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.delete :utf8
      params.permit!#(:name, :phone, :address, :logo, :contact_person, :avg_price, :site, :notes, :service_id, :service_ids)
    end    
    
    def authenticate_user_admin!
      if admin_signed_in? then
        #p admin_signed_in?
        return true
      else if !user_signed_in? then
        redirect_to new_user_session_path
      end
      end
    end
  
    def user_active!
      unless current_user.locked?
        return true
      end
      redirect_to root_url, :notice => "Your account is locked."
      return false
    end
end
