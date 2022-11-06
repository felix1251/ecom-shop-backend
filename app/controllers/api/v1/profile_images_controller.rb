class Api::V1::ProfileImagesController < ApplicationController
  before_action :set_profile_image, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /profile_images
  def index
    @profile_images = current_user.profile_images
    render json: @profile_images
  end

  # GET /profile_images/1
  def show
    render json: @profile_image
  end

  # POST /profile_images
  def create
    @profile_image = current_user.profile_images.build(profile_image_params)
    if @profile_image.save
      render json: @profile_image, status: :created
    else
      render json: @profile_image.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @profile_image.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_image
      @profile_image = ProfileImage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def profile_image_params
      params.require(:profile_image).permit(:img_url)
    end
end
