class Api::V1::PortfoliosController < ApplicationController
    before_action :authenticate_user, except: [:index]

    def index
        @new_portfolios = Portfolio.limit(10).order('created_at DESC').includes(:user)
        render json: {status: 200, data: @new_portfolios }
    end

end
