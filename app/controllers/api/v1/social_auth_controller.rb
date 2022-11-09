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
      render json: @user
    else
      render json: {error: "can't sign in, something is wrong"}
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

  # def set_headers(tokens)
  #   response.headers['access-token'] = tokens['access-token']
  #   response.headers['client'] = tokens['client']
  #   response.headers['expiry'] = tokens['expiry']
  #   response.headers['token-type'] = tokens['token-type']
  #   response.headers['uid'] = tokens['uid']
  # end
end