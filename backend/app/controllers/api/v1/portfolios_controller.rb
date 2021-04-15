class Api::V1::PortfoliosController < ApplicationController
    before_action :authenticate_user, except: [:index]

    def index
        @new_arrival = Portfolio.limit(10).order("created_at DESC").includes(:user)
        @highly_creativity = matched_portfolios(AvgEval.search_columns(10, "creativity", "portfolio_id".intern))
        @highly_sociality = matched_portfolios(AvgEval.search_columns(10, "sociality", "portfolio_id".intern))
        @highly_skill = matched_portfolios(AvgEval.search_columns(10, "skill", "portfolio_id".intern))
        @highly_usability = matched_portfolios(AvgEval.search_columns(10, "usability", "portfolio_id".intern))
        @highly_business_oriented = matched_portfolios(AvgEval.search_columns(10, "business_oriented", "portfolio_id".intern))
        @highly_comprehensive_evaluation = matched_portfolios(AvgEval.search_columns(10, "comprehensive_evaluation", "portfolio_id".intern))
        render json: {status: 200, 
                      new_arrival: @new_arrival, 
                      highly_creativity: @highly_creativity,
                      highly_sociality:  @highly_sociality,
                      highly_skill: @highly_skill,
                      highly_usability: @highly_usability,
                      highly_business_oriented: @highly_business_oriented,
                      highly_comprehensive_evaluation: @highly_comprehensive_evaluation
                    }
    end

    def matched_portfolios(ids)
        array = []
        ids.map{ |id|
            array.push(Portfolio.find(id)) 
            } 
        return array
    end
end
