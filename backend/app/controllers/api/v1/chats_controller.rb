class Api::V1::ChatsController < ApplicationController
    before_action :authenticate_user, except: [:index, :create]

    def index
      @chats = Chat.where(portfolio_id: params[:portfolio_id]).includes(:user)

        #単純にincludes(:user)したものをReeactに渡しても、使えないので以下の処理。
        #サービスオブジェクトにするかは、いったん保留
        array = []
        @chats.map{ |chat|
            user = chat.user.image.attached? ? chat.user.attributes.merge({image: url_for(chat.user.image)}) : chat.user
            array.push(user_fields(user.to_json)) 
            } 
      render json: {status: 200, data: @chats, user: array}
    end

    def create
      @chat = Chat.new(chats_params)
      if @chat.save
        render json: {status: 201, data: @chat}
      else
       #saveできなかった時の処理
      end
    end


    private
    def chats_params
        params.permit(:text, :portfolio_id, :user_id)
    end
    
    def user_fields(user_json)
        user_parse = JSON.parse(user_json)
        user_parse.except('created_at', 'email' ,'password_digest')
    end
end

