class Api::V1::ProfilesController < ApplicationController

  def create
    if Profile.find_by(user_id: params[:user_id]).present?
      update
    else
      @profile = Profile.new(profiles_params)
      if @profile.invalid? 
        render json: {status: 404, data:  @profile.errors.full_messages} 
      elsif @profile.save
        render json: {status: 201, data: except_fields(@profile, []) } 
      else
        response_internal_server_error
      end
    end
  end

  def update
    @profile = Profile.find_by(user_id: params[:user_id])
    if @profile.invalid?
      render json: {status: 404, data:  @profile.errors.full_messages} 
    elsif @profile.update(profiles_params)
      render json: {status: 201, data: except_fields(@profile, []) } 
    else
      response_internal_server_error
    end
  end

  private
    def profiles_params
      params.permit(:nickname, :image, :self_introduction, :web_site_url, :programming_start_date, :user_id)
    end
end
