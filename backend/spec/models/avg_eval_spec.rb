require 'rails_helper'

RSpec.describe AvgEval, type: :model do
  before do 
    @eval = FactoryBot.build(:eval)
    @eval.save
    @portfolio_id = {portfolio_id: @eval.portfolio_id}
    @avg_eval = FactoryBot.build(:avg_eval)
  end
  describe "ポートフォリオの評価の投稿" do
    context "正常系" do
      it "初回の評価が投稿された場合 " do
          @avg_eval.valid?
          expect(@avg_eval).to be_valid
      end
      it "２回目以降の評価が投稿されたとき平均値を計算する" do
        @avg_eval.portfolio_id = @eval.portfolio_id
        @avg_eval.save   #１回目の投稿
        @avg_eval = AvgEval.find_by(@portfolio_id)
        avg_params = AvgEval.calcurate({existing_records: Eval.where(@portfolio_id),  new_arrival: @eval })
        #計算値が平均になっているかの検証はいったん保留
      end
    end
  end
end
