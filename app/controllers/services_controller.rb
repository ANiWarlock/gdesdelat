class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  #before_filter :authenticate_user!, except: [:show, :index]
  before_filter :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  

  # GET /services
  # GET /services.json
  
  def start_page  
    @remont = Company.joins(:csasses).where("csasses.service_id = ?", 3).find(:all, :order => "csasses.subscription_type ASC", :limit => 6)
    @companies_2 = Company.joins(:services).where("service_id != ?", 3).limit(6)
    @companies_3 = Company.joins(:services).where("service_id != ?", 16).limit(6)
  end
  
  def index
    @services = Service.where("id != ? and id != ?",3,16)
    @companies = Company.all
  end  
  
  def third_service
    @service = Service.find(3)
    @companies = Company.all
    render 'services/remont'
  end

  def store
    @service = Service.find(16)
    @companies = Company.all
    render 'services/store'
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
        format.json { render action: 'show', status: :created, location: @service }
      else
        format.html { render action: 'new' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params[:service].permit!
    end
end
