class Api::V1::CategoriesController < ApplicationController
  before_action :set_categories

    def incremental_search
      render json: {data: @categories ?  @categories : []}
    end

    def search 
      if @categories.size > 0
        @portfolios = @categories.map{|c|
          c.portfolios
          }
        render json: {data: @portfolios ? @portfolios : []}
      else
        render json: {data: []}
      end
      
    end



    def set_categories
      elements = {
        obj: Category,
        keyword_column: 'name',
        keyword: params[:keyword],
      }
      @categories = SearchService.call(elements)
    end
end