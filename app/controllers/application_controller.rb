class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::RequestForgeryProtection
  protect_from_forgery unless: -> { request.format.json? } 

  private

  def current_user
    #get user id from stored session warden
    if session['warden.user.user.key']
      User.select("id, email, name, provider").find_by(id: session["warden.user.user.key"][0][0]) 
    end
  end
end
