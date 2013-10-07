class UsersController < ApplicationController
  before_filter :authenticate_admin!, only: :index
  
  def show
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.all
  end
  
end
