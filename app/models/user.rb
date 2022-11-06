class User < ApplicationRecord
    
  devise :database_authenticatable, :registerable, :trackable,
          :recoverable, :rememberable, :validatable, :confirmable,
          :omniauthable, omniauth_providers: %i[google_oauth2] 

  include  DeviseTokenAuth::Concerns::User 

  has_many :profile_images, :dependent => :destroy

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true,
            uniqueness: true

  private

  def self.signin_or_create_from_google(data)
    where(provider: data["iss"], uid: data["sub"], email: data["email"]).first_or_create do |user|
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation! 
    end
  end
end