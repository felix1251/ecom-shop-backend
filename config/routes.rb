require 'sidekiq/web'
# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == ENV['SIDEKIQ_USERNAME'] && password == ENV['SIDEKIQ_PASSWORD']
end

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', skip: [:omniauth_callbacks, :sessions, :registration, :password, :validations, :token_validations]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      #auth controllers
      post 'google_auth/callback', to: 'social_auth#authenticate_by_google'
      get 'me', controller: :infos, action: :me
      delete "logout", to: 'social_auth#log_out'
      #crud controllers
      resources :users
      resources :profile_images
    end
  end
end
