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
        @chat_with_user_profile = chat_with_user_profile(@chat)
        render json: {status: 201, data: @chat_with_user_profile}
      else
        #saveできなかった時の処理
      end
    end


    private
    def chats_params
        params.permit(:text, :portfolio_id, :user_id)
    end

    
    def except_records_fields(records, except_keywords_in_array)
      result = records.map{|record|
        except_fields(record, except_keywords_in_array)
      }
      result
    end


    def except_fields(a_record, except_keywords_in_array) 
        a_json_data = a_record.to_json()
        parsed_data = JSON.parse(a_json_data)
        result = parsed_data.except(*except_keywords_in_array)
        result
    end 



    def chat_with_user_profile(chat)
      profile = chat.user.profile.image.attached? ? chat.user.profile.attributes.merge({image: url_for(chat.user.profile.image)}) : chat.user.profile
      profile_hash = profile.attributes
      chat_hash = chat.attributes
      result = chat_hash.merge(profile_hash)
      result
    end

end

