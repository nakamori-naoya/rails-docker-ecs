class Api::V1::PortfoliosController < ApplicationController
    before_action :authenticate_user, except: [:index, :show]

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
                    newArrival: MergeRecordsWithProfile.call(@new_arrival) ,
                    highCreativity: @high_creativity ? MergeRecordsWithProfile.call(@high_creativity) : [],
                    highSociality:  @high_sociality ? MergeRecordsWithProfile.call(@high_sociality ): [],
                    highSkill: @high_skill ? MergeRecordsWithProfile.call(@high_skill) : [],
                    highUsability: @high_usability ? MergeRecordsWithProfile.call(@high_usability) : [],
                    highBusinessOriented: @high_business_oriented ? MergeRecordsWithProfile.call(@high_business_oriented) : [],
                    highComprehensiveEvaluation: @high_comprehensive ? MergeRecordsWithProfile.call(@high_comprehensive) : []
                }
    end
    
    #カテゴリは複数投稿できるので、配列で送られてくるはず。なので、PortfolioCategoryFormの処理で工夫が必要
    def create
            @portfolio_category_form = PortfolioCategoryForm.new(portfolios_params)
        if @portfolio_category_form.save
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
        # params.permit(:title, :description, :site_url, :github_url, :user_id, :images , :name)
        params.permit(:title, :description, :site_url, :github_url, :user_id, :images, :name)
    end

end
