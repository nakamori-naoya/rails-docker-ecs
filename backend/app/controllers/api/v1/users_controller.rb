class Api::V1::UsersController < ApplicationController
    # before_action :authenticate_user, except: [:create, :logout]
# curl -X "GET" "http://localhost:3000/api/v1/users" -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MTU2OTc4MTcsInN1YiI6MX0.HMjFKqWzMJW8Jy28aZWpjldHaMPsknWjZAh7UuX4rY0" -H "Content-Type: application/json"

    def index
        if current_user?
          @image = current_user.image.attached? ? user.attributes.merge({image: url_for(current_user.image)}) :user
          render json: {status: 200, user: current_user, image: @image}
        else
          response_not_found("user")
        end
        
    end


    def create
        @user = User.new(users_params)
        if @user.email.blank?
          response_bad_request
        else
            if @user.save
              render json: {status: 201, data: current_user }
            else
              response_internal_server_error
            end
          end
        end

        # def show
        #   user = current_user
        #   render json: {status: 200, data: current_user.to_json }
        # end

      def logout
        render json: {status: 200}
      end

      def update
          user = User.find(params[:id])
          user.image.attach(params[:image])
          user.update(users_params)

          user=  User.find(params[:id])
          @image = user.image.attached? ? user.attributes.merge({image: url_for(user.image)}) :user
          render json: {status: 200, data: @image}
      end

      private
      def users_params
        params.permit(:email, :password, :nickName, :image)
      end

end
