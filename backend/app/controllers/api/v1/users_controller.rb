class Api::V1::UsersController < ApplicationController
    before_action :authenticate_user, except: [:create, :logout, :destroy]
# curl -X "GET" "http://localhost:3000/api/v1/users" -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MTU2OTc4MTcsInN1YiI6MX0.HMjFKqWzMJW8Jy28aZWpjldHaMPsknWjZAh7UuX4rY0" -H "Content-Type: application/json"

    def index
       @user = current_user.image.attached? ? current_user.attributes.merge({image: url_for(current_user.image)}) : current_user
       render json: {status: 200, data: response_fields(@user.to_json)}
    end


    def create
        @user = User.new(users_params)
        if @user.email.blank?
          response_bad_request
        else
            if @user.save
              render json: {status: 201, data: @user }
            else
              response_internal_server_error
            end
          end
        end


      def logout
        render json: {status: 200}
      end

      def update
          previous_user = User.find(params[:id]) 
          previous_user.update(users_params)
          @user = current_user.image.attached? ? current_user.attributes.merge({image: url_for(current_user.image)}) : current_user
          render json: {status: 200, data: response_fields(@user.to_json)}
      end

      
      def destroy
        user = User.find(params[:id]) 
        user.destroy
        render json: {status: 200}
      end

      private
      def users_params
        params.permit(:id, :email, :password, :nickName, :image)
      end

      def response_fields(user_json)
        user_parse = JSON.parse(user_json)
        user_parse.except('created_at', 'email' ,'password_digest')
      end

end
