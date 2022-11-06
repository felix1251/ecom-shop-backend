class Api::V1::InfosController < ApplicationController
  before_action :admin_only, :except => :me
  before_action :authenticate_user!
  
  #current account
  def me
    render json: current_user
  end

  #all users
  def index
    @users = User.all
    render json: @users
  end

end