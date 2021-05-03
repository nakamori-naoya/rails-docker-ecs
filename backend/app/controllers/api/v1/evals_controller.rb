class Api::V1::EvalsController < ApplicationController
    #immutableDataModelingに基づき、CRを想定

    def create
      @eval = Eval.new(evals_params)
      if @eval.save
        if AvgEval.exists?(portfolio_id: params[:portfolio_id])
           redirect_to controller: :avg_evals, action: :index
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
