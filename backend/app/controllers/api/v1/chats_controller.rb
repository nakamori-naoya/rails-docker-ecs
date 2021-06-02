class Api::V1::ChatsController < ApplicationController
    before_action :authenticate_user, except: [:index, :create]

    def index
      @chats = Chat.includes(:user).profile.where(portfolio_id: params[:portfolio_id])
      @chats = Chat.includes(user: :profile).where(portfolio_id: 1)
        #単純にincludes(:user)したものをReactに渡しても、使えないので以下の処理。
        #サービスオブジェクトにするかは、いったん保留
      @chats_with_user_profile = @chats.map {|chat|
          profile = chat.user.profile.image.attached? ? chat.user.profile.attributes.merge({image: url_for(chat.user.profile.image)}) : chat.user.profile
          profile_hash = profile.attributes
          chat_hash = chat.attributes
          chat_hash.merge(profile_hash)
          
      }
      render json: {status: 200, data: @chats_with_user_profile}
    end

    
    def create
      @chat = Chat.new(chats_params)
      #@chat = Chat.new({text: "aaaa", user_id: 1, portfolio_id: 1})
      if @chat.save
        render json: {status: 201, data: @chat , user: @chat.user}
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

