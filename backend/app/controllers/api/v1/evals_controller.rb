class Api::V1::EvalsController < ApplicationController
    #immutableDataModelingに基づき、CRを想定

    def create
      @eval = Eval.new(evals_params)
      ActiveRecord::Base.transaction do
      portfolio_id = {portfolio_id: params[:portfolio_id]}
        if @eval.save
          #イメージの処理 avg_eval = AvgEval.new して avg_eval.calcurate(portfolio_id, Eval.where(portfolio_id), @eval)
          if AvgEval.exists?(portfolio_id)
            @avg_eval = AvgEval.find_by(portfolio_id)
            avg_params = AvgEval.calcurate({
              existing_records: Eval.where(portfolio_id),  
              new_arrival: @eval,  params: {}})
            @avg_eval.update(avg_params)
            render json: {status: 200, data: except_fields(@avg_eval,[]) }
          else
            @avg_eval =   AvgEval.create(avg_evals_params)  #新規作成の場合
            render json: {status: 201, data: except_fields(@avg_eval,[])}
          end
        else
          response_internal_server_error
        end
      end
    end

    def update 

    end


    private

    def evals_params
        #user_idとportfolio_idもReactから送ることを想定しておく
      params.permit(:usability, :sociality,  
                    :business_oriented, :creativity, 
                    :skill, :comprehensive_evaluation, 
                    :user_id, :portfolio_id
                    )
    end

    def avg_evals_params
      #user_idとportfolio_idもReactから送ることを想定しておく
    params.permit(:usability, :sociality,  :business_oriented, :creativity, 
                  :skill, :comprehensive_evaluation,  :portfolio_id
                  )
  end

end
