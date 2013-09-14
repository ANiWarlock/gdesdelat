class CsassesController < ApplicationController
  def index
    @company = Company.find(params[:id])
    @csasses = @company.csasses
    render 'companies/csasses/index'
  end
  private 
    def csass_params
      params.permit!#(:name, :phone, :address, :logo, :contact_person, :avg_price, :site, :notes, :service_id, :service_ids)
    end  
end
