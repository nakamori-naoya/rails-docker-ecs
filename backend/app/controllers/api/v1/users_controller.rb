class Api::V1::UsersController < ApplicationController
    before_action :authenticate_user, except: [:create, :logout]
    
    def index
        users = User.all
        user = current_user
        render json: {status: 200, users: except_datas(users.json), user: except_data(current_user.to_json),  }
    end

    def create
        @user = User.new(users_params)
        if @user.save
          response_success(:user, :create)
        else
          response_internal_server_error
        end
    end

    # def logout
    #     render json: {status: 200}
    # end

    def users_params
        params.permit(:email, :password :nickName)
    end

    def except_data(data)
        user_parse = JSON.parse(data)
        user_parse.except('created_at', 'updated_at', 'password', 'password_digest')
    end

    def except_datas(datas)
        datas.each do |data|
          data_parse = Json.parse(data)
          data_parse.except('created_at', 'updated_at', 'password', 'password_digest')
        end
    end
        
end

#rails g controller appi::v1::usersコマンドで作成
