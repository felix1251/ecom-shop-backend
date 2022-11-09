# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins '*'

#     resource '*',
#       headers: :any,
#       methods: [:get, :post, :put, :patch, :delete, :options, :head]
#   end
# end

# Rails.application.config.session_store :cookie_store, key: '_interslice_session'
# Rails.application.config.middleware.use ActionDispatch::Cookies # Required for all session management
# Rails.application.config.middleware.use ActionDispatch::Session::CookieStore, Rails.application.config.session_options
# I added this for cors to be able to accept request from client. for now it accepts from all origins
Rails.application.config.middleware.insert_before 0, Rack::Cors  do
  allow do
    origins 'http://localhost:8080'
    resource '*',
            headers: :any,
            credentials: true,
            # expose: ['access-token', 'token', 'expiry', 'token-type', 'uid', 'client'],
            methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end