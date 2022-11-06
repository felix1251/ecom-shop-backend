class Api::V1::MeController < ApplicationController
      before_action :authenticate_user!

      def me
            render json: current_user
      end
end