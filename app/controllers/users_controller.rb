class UsersController < ApplicationController


  before_action :authenticate_user!
  
  # Get users with profiles attached to optimize database access
  def index
    @users = User.includes(:profile)
  end
  
  # GET /users/:id
  def show
    @user = User.find( params[:id])
  end
  
end