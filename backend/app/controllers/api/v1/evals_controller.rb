class Api::V1::EvalsController < ApplicationController
    #immutableDataModelingに基づき、CRを想定

    
    def create
      @eval = Eval.new(evals_params)
      if @eval.save
        #averageを求める処理はここに残したくない泣
        if AvgEval.exists?(portfolio_id: params[:portfolio_id])
            @evals = Eval.where(portfolio_id: params[:portfolio_id])
            array = [:sociality, :creativity, :usability, :business_oriented, :skill, :comprehensive_evaluation]
            props = {portfolio_id: params[:portfolio_id]}
            array.map { |column|
                datas = @evals.pluck(column)
            props[column] = datas.sum(0.0) / datas.length
            }
            @existing_eval = AvgEval.find_by(portfolio_id: params[:portfolio_id])
            @existing_eval.update(props)
        else
            AvgEval.create(evals_params)
        end
      else
        response_internal_server_error
      end
    end




    private

    def evals_params
        #user_idとportfolio_idもReactから送ることを想定しておく
      params.permit(:usability, :sociality, :sociality, 
                    :business_oriented, :creativity, 
                    :skill, :comprehensive_evaluation, 
                    :user_id, :portfolio_id
                    )
    end

end
