class WelcomeController < ApplicationController
      def index
            msg = "Welcome :)"
            render json:  {:message => msg}
      end
end