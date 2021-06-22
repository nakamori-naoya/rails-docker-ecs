class Api::V1::ChatsController < ApplicationController
    before_action :authenticate_user, except: [:index, :create]

    def index
      @chats = Chat.includes(user: :profile).where(portfolio_id: params[:portfolio_id])
      @chats_with_user_profile = @chats.map {|chat|
          chat_with_user_profile(chat)
      }
      render json: {status: 200, data: @chats_with_user_profile}
    end

    
    def create
      @chat = Chat.new(chats_params)
      # @chat= Chat.first
      #@chat = Chat.new({text: "aaaa", user_id: 1, portfolio_id: 1})
      if @chat.save
        @chat_with_user_profile = merge_records_with_profile(@chat)
        render json: {status: 201, data: @chat_with_user_profile}
      else
        #saveできなかった時の処理
      end
    end


    private
    def chats_params
        params.permit(:text, :portfolio_id, :user_id)
    end

end

