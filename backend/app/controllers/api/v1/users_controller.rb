class Api::V1::UsersController < ApplicationController
    before_action :authenticate_user, except: [:create, :logout]
# curl -X "GET" "http://localhost:3000/api/v1/users" -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MTU2OTc4MTcsInN1YiI6MX0.HMjFKqWzMJW8Jy28aZWpjldHaMPsknWjZAh7UuX4rY0" -H "Content-Type: application/json"

    def index
        login_user = current_user
        render json: {status: 200, loginUser: response_fields(current_user.to_json) }
    end

    def create
        @user = User.new(users_params)
        if @user.email.blank?
          response_bad_request
        else
            if @user.save
              # bucket = Aws::S3::Resource.new(
              #   :region => 'ap-northeast-1',
              #   :access_key_id => ENV['AWS_ACCCES_KEY'],
              #   :secret_access_key => ENV['AWS_ACCCES_SECRET_KEY'],
              #   ).bucket('react-rails') 
              # # sample_bucketにencodeされた画像データをupload
              # bucket.object("user_id_#{user.id}_profile_image").put(:body => params[:profile_image])
              render json: {status: 201, data: response_fields(current_user.to_json) }
            else
              response_internal_server_error
            end
          end
        end

        # def show
        #   user = current_user
        #   render json: {status: 200, data: response_fields(current_user.to_json) }
        # end

      def logout
        render json: {status: 200}
      end

      private

      def users_params
        params.permit(:email, :password, :nickName)
      end

      def response_fields(user_json)
        user_parse = JSON.parse(user_json)
        user_parse.except('password', 'password_digest', "email")
      end

end
