class Api::V1::PortfoliosController < ApplicationController
    before_action :authenticate_user, except: [:index, :show]

    def index
        #究極的に検索にもmatched_portfolios()のロジックは使えますね！！
        #中森流のサービスオブジェクト使用ルールとして、複数のオブジェクトにまたがるビジネスロジックの記述
        @new_arrival = Portfolio.limit(10).order("created_at DESC")
        @high_creativity = Portfolio.matched_portfolios(AvgEval.search_columns(10, 
                                                            "creativity", 
                                                            "portfolio_id".intern)
                                                        )
        @high_sociality = Portfolio.matched_portfolios(AvgEval.search_columns(10, 
                                                            "sociality", 
                                                            "portfolio_id".intern)
                                                        )
        @high_skill = Portfolio.matched_portfolios(AvgEval.search_columns(10, 
                                                            "skill", 
                                                            "portfolio_id".intern)
                                                        )
        @high_usability = Portfolio.matched_portfolios(AvgEval.search_columns(10, 
                                                            "usability", 
                                                            "portfolio_id".intern)
                                                        )
        @high_business_oriented = Portfolio.matched_portfolios(AvgEval.search_columns(10, 
                                                            "business_oriented", 
                                                            "portfolio_id".intern)
                                                        )
        @high_comprehensive_evaluation = Portfolio.matched_portfolios(AvgEval.search_columns(10, 
                                                            "comprehensive_evaluation", 
                                                            "portfolio_id".intern))
        render json: {status: 200, 
                    newArrival: @new_arrival, 
                    highCreativity: @high_creativity,
                    highSociality:  @high_sociality,
                    highSkill: @high_skill,
                    highUsability: @high_usability,
                    highBusinessOriented: @high_business_oriented,
                    highComprehensiveEvaluation: @high_comprehensive_evaluation
                }
    end

    def create
        @portfolio_category_form = PortfolioCategoryForm.new(portfolios_params)
        if @portfolio_category_form.save!
            #値を返す
        else
            #エラーコードを送る
        end
    end

    def search
        #引数で送られてきた数字と評価項目のポートフォリオを返す関数にしたい
    end

    
    def show
        @portfolio = Portfolio.find(params[:id])
        render json: {status: 200, data: @portfolio}
    end


    private
    def portfolios_params
        params.permit(:title, :description, :site_url, :github_url, :name, :images, :user_id)
    end
end
