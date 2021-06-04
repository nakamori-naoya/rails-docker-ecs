class Api::V1::AvgEvalsController < ApplicationController
 


    def show 
        @avg_eval = AvgEval.find_by(portfolio_id: params[:portfolio_id])
        render json: {status: 200, data: avg_eval_fields(@avg_eval.to_json)}
    end


    #カラムの要素を弾く処理は、どこかアプリケーションサービスとしてまとめて記述するのはどうか？  ※ドメインサービスでは絶対にない
    #引数に配列もしくは連想配列で除外したい要素を渡し、処理をさせる。
    private
    def avg_eval_fields(avg_eval_json)
        avg_eval_parse = JSON.parse(avg_eval_json)
        avg_eval_parse.except('id','user_id','created_at', 'updated_at')
    end
    
end
