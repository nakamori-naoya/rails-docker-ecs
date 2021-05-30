class Api::V1::EvalsController < ApplicationController
    #immutableDataModelingに基づき、CRを想定

    def create
      @eval = Eval.new(evals_params)
      portfolio_id = {portfolio_id: params[:portfolio_id]}
      if @eval.save
        #イメージの処理 avg_eval = AvgEval.new して avg_eval.calcurate(portfolio_id, Eval.where(portfolio_id), @eval)
        if AvgEval.exists?(portfolio_id)
          avg_params = AvgEval.calcurate(portfolio_id, Eval.where(portfolio_id), @eval)
          @old_avg_eval = AvgEval.find_by(portfolio_id)
          @avg_eval =  @old_avg_eval.update(avg_params)
          render json: {status: 200, data: avg_eval_fields(@avg_eval.to_json)}
        else
          @avg_eval =   AvgEval.create(evals_params)  #新規作成の場合
          render json: {status: 201, data: avg_eval_fields(@avg_eval.to_json)}
        end
      else
        response_internal_server_error
      end
    end

    def update 

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

    def avg_eval_fields(avg_eval_json)
      user_parse = JSON.parse(avg_eval_json)
      user_parse.except('id','user_id','created_at', 'updated_at')
    end

end
