class CsassesController < ApplicationController
  before_filter :authenticate_admin!, only: :index
  def index
    @company = Company.find(params[:id])
    @csasses = @company.csasses
    render 'companies/csasses/index'
  end
  
  def deligate
    @company = Company.find(params[:id])
    @csass = @company.csasses.where("service_id = ?", params[:service_id]).first
  @csass.update_attributes(:subscription_type => 1, :subscription_date => Time.now, :subscription_until => (Time.now + 1.month))

  respond_to do |format|
      if @csass.save
        format.html { redirect_to @company, notice: 'Subscription updated!' }
      else
        format.html { render action: 'new' }
      end
    end      
  end
    
    
  private 
    def csass_params
      params.permit!#(:name, :phone, :address, :logo, :contact_person, :avg_price, :site, :notes, :service_id, :service_ids)
    end  
end
