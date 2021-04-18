class Api::V1::PortfoliosController < ApplicationController
    before_action :authenticate_user, except: [:index]

    def index
        #究極的に検索にもmatched_portfolios()のロジックは使えますね！！
        @new_arrival = Portfolio.limit(10).order("created_at DESC").includes(:user)
        @high_creativity = matched_portfolios(AvgEval.search_columns(10, "creativity", "portfolio_id".intern))
        @high_sociality = matched_portfolios(AvgEval.search_columns(10, "sociality", "portfolio_id".intern))
        @high_skill = matched_portfolios(AvgEval.search_columns(10, "skill", "portfolio_id".intern))
        @high_usability = matched_portfolios(AvgEval.search_columns(10, "usability", "portfolio_id".intern))
        @high_business_oriented = matched_portfolios(AvgEval.search_columns(10, "business_oriented", "portfolio_id".intern))
        @high_comprehensive_evaluation = matched_portfolios(AvgEval.search_columns(10, "comprehensive_evaluation", "portfolio_id".intern))
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
    

    def search
        #引数で送られてきた数字と評価項目のポートフォリオを返す関数にしたい
    end

    def matched_portfolios(ids)
        array = []
        ids.map{ |id|
            array.push(Portfolio.find(id)) 
            } 
        return array
    end
end
