class Api::V1::EvalsController < ApplicationController
    #immutableDataModelingに基づき、CRを想定
    
    def create
      @eval = Eval.new(evals_params)
      if @eval.save
        @evals = Eval.where(portfolio_id: params[:portfolio_id])
        array = [:sociality, :creativity, :usability, :business_oriented, :skill, :comprehensive_evaluation]
        props = {portfolio_id: params[:portfolio_id], user_id: params[:user_id] }
        args = {array: array, props: props, self: @evals}
        values = @evals.average(args)        
        AvgEval.create(values)
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
