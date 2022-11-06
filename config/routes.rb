Rails.application.routes.draw do
  # devise_for :users
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', skip: [:omniauth_callbacks, :sessions, :registration, :password, :validations, :token_validations]
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      #auth controllers
      post 'auth/google/callback', to: 'social_auth#authenticate_by_google'
      post 'auth/email', to: 'social_auth#authenticate_by_email'
      post 'auth/signup_by_email', to: 'social_auth#sign_up_by_email'
      get 'current_user/me', controller: :infos, action: :me
      delete "logout", to: 'social_auth#log_out'
      #crud controllers
      resources :users
      resources :profile_images
    end
  end
end
