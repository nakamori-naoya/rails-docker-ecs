class Api::V1::UsersController < ApplicationController
    before_action :authenticate_user, except: [:create, :logout, :destroy, :incremental_search, :search]
# curl -X "GET" "http://localhost:3000/api/v1/users" -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MTU2OTc4MTcsInN1YiI6MX0.HMjFKqWzMJW8Jy28aZWpjldHaMPsknWjZAh7UuX4rY0" -H "Content-Type: application/json"
    def index
      if current_user
        if current_user.profile.present?
          @profile = current_user.profile.image.attached? ? 
                    current_user.profile.attributes.merge({image: rails_storage_proxy_url(current_user.profile.image), id: current_user.id}) 
                    : 
                    current_user.profile.merge({id: current_user.id})
          render json: {status: 200, data: except_fields(@profile, [])}
        else
          render json: {status: 200, data: except_fields(current_user, ["email" , "password_digest", "created_at", "updated_at"]  )}
        end
      else
        #
      end
    end


    def create
      @user = User.new(users_params)
      if @user.email.blank?
        response_bad_request
      else
        if @user.invalid?
          render json: {status: 404, data:  @user.errors.full_messages} 
        elsif @user.save
          render json: {status: 201, data: except_fields(@user, ["email" , "password_digest", "created_at", "updated_at"]  ) } 
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
          @user = current_user.image.attached? ? current_user.attributes.merge({image: rails_storage_proxy_url(current_user.image)}) : current_user
          render json: {status: 200, data: response_fields(@user.to_json)}
      end

      
      def destroy
        user = User.find(params[:id]) 
        user.destroy
        render json: {status: 200}
      end

      def incremental_search
        elements = {
          obj: Profile,
          keyword_column: 'nickname',
          keyword: params[:keyword],
        }
        @profiles = SearchService.call(elements)
        render json: {data: except_records_fields(@profiles, [])}
      end

      def search
        elements = {
          obj: Profile,
          keyword_column: 'nickname',
          keyword: params[:keyword],
        }
        @profiles = SearchService.call(elements)
        render json: {data: except_records_fields(@profiles, [])}
      end

      private
      def users_params
        params.permit(:id, :email, :password, :nickName, :image)
      end
end
