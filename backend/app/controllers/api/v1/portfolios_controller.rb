class Api::V1::PortfoliosController < ApplicationController
    before_action :authenticate_user, except: [:index, :show, :search]

    def index
        @new_arrival = Portfolio.includes(user: :profile).limit(10).order("created_at DESC")
        @high_creativity = Portfolio.includes(user: :profile).where(id: AvgEval.search_columns(10, 
                                                            "creativity", 
                                                            "portfolio_id".intern)
                                                        )
        @high_sociality = Portfolio.includes(user: :profile).where(id: AvgEval.search_columns(10, 
                                                            "sociality", 
                                                            "portfolio_id".intern)
                                                        )
        @high_skill = Portfolio.includes(user: :profile).where(id: AvgEval.search_columns(10, 
                                                            "skill", 
                                                            "portfolio_id".intern)
                                                        )
        @high_usability = Portfolio.includes(user: :profile).where(id: AvgEval.search_columns(10, 
                                                            "usability", 
                                                            "portfolio_id".intern)
                                                        )
        @high_business_oriented = Portfolio.includes(user: :profile).where(id: AvgEval.search_columns(10, 
                                                            "business_oriented", 
                                                            "portfolio_id".intern)
                                                        )
        @high_comprehensive = Portfolio.includes(user: :profile).where(id: AvgEval.search_columns(10, 
                                                            "comprehensive_evaluation", 
                                                            "portfolio_id".intern))
        render json: { 
                    newArrival: merge_records_with_profile(@new_arrival) ,
                    highCreativity: @high_creativity ? merge_records_with_profile(@high_creativity) : [],
                    highSociality:  @high_sociality ? merge_records_with_profile(@high_sociality ): [],
                    highSkill: @high_skill ? merge_records_with_profile(@high_skill) : [],
                    highUsability: @high_usability ? merge_records_with_profile(@high_usability) : [],
                    highBusinessOriented: @high_business_oriented ? merge_records_with_profile(@high_business_oriented) : [],
                    highComprehensiveEvaluation: @high_comprehensive ? merge_records_with_profile(@high_comprehensive) : []
                }
    end
    
    #カテゴリは複数投稿できるので、配列で送られてくるはず。なので、PortfolioCategoryFormの処理で工夫が必要
    def create
            @portfolio_category_form = PortfolioCategoryForm.new(portfolios_params)
        if @portfolio_category_form.save
            render json: {data: @portfolio_category_form}
        else
            #エラーコードを送る
        end
    end

    def search
        elements = {
            obj: Portfolio,
            keyword_column: 'title',
            keyword: params[:keyword],
        }
        @portfolios = SearchService.call(elements)
        render json: {data: @portfolios}
    end

    
    def show
        @portfolio = Portfolio.find(params[:id])
        @added_profile = merge_records_with_profile(@portfolio)
        @added_portfolio = @added_profile.merge({chats: merge_records_with_profile(@portfolio.chats), avg_eval: @portfolio.avg_eval})
        #のちに「良いね」も一緒にrenderする予定
        render json: {status: 200, data: @added_portfolio}
    end


    private
    def portfolios_params
        # params.permit(:title, :description, :site_url, :github_url, :user_id, :images , :name)
        params.permit(:id ,:title, :description, :site_url, :github_url, :user_id, :images, :name)
    end

end
