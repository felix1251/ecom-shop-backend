require 'test_helper'

class ProfileImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile_image = profile_images(:one)
  end

  test "should get index" do
    get profile_images_url, as: :json
    assert_response :success
  end

  test "should create profile_image" do
    assert_difference('ProfileImage.count') do
      post profile_images_url, params: { profile_image: { img_url: @profile_image.img_url } }, as: :json
    end

    assert_response 201
  end

  test "should show profile_image" do
    get profile_image_url(@profile_image), as: :json
    assert_response :success
  end

  test "should update profile_image" do
    patch profile_image_url(@profile_image), params: { profile_image: { img_url: @profile_image.img_url } }, as: :json
    assert_response 200
  end

  test "should destroy profile_image" do
    assert_difference('ProfileImage.count', -1) do
      delete profile_image_url(@profile_image), as: :json
    end

    assert_response 204
  end
end
