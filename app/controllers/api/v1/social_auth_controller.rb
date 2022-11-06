require 'json'
require 'httparty'
class Api::V1::SocialAuthController < ApplicationController
  before_action :authenticate_user!, :only => :log_out
  before_action :check_google_params, :only => :authenticate_by_google
  SIGN_UP_KEYS = [:email, :password, :password_confirmation].freeze

  def authenticate_by_google
    googleApiUrl = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{params[:id_token]}"                  
    response = HTTParty.get(googleApiUrl)
    @user = User.signin_or_create_from_google(response.parsed_response)
    if @user.persisted?
      sign_in(@user)
      render json: { status: 'SUCCESS', message: "You are successfully logged in through Google", is_user_signed_in: user_signed_in? }, status: :created
    else
      render json: { status: 'FAILED', message: "There was a problem signing you in through Google",  data: @user.errors }, status: :unprocessable_entity
    end
  end

  def log_out 
    reset_session
    render json: { status: "SUCCESS", message: "Logout sucessfully" } , status: :ok
  end

  private

  def check_google_params
    if !params[:id_token].present?
      render json: { error: "Missing Params" } , status: :unprocessable_entity
    end
  end
end