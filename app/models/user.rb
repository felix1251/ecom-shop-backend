class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :trackable,
          :recoverable, :rememberable, :validatable, :confirmable,
          :omniauthable, omniauth_providers: %i[google_oauth2] 

  include  DeviseTokenAuth::Concerns::User 

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true,
            uniqueness: true

  private

  def self.signin_or_create_from_google(data)
    where(uid: data["sub"], email: data["email"]).first_or_create do |user|
      user.provider = "google_oauth2"
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation! 
    end
  end
end