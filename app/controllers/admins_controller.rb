class AdminsController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @admins = Admin.all
  end
  def show
    redirect_to root_url
  end
  
end
