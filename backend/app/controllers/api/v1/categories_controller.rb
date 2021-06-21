class Api::V1::CategoriesController < ApplicationController

    def search
      # searchの引数は下記の構成で、検索に必要な情報だけ送る。objは必須。
      elements = {
        obj: Category,
        keyword_column: 'name',
        keyword: params[:keyword],
      }
      @categories = SearchService.call(elements)
      render json: {data: @categories}
    end
end
