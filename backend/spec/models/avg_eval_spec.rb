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
      it "評価が投稿された場合 ※2回目以降" do
        @avg_eval.portfolio_id = @eval.portfolio_id
        @avg_eval.save
        @another_avg_eval = AvgEval.find_by(@portfolio_id)
        avg_params = AvgEval.calcurate(@portfolio_id, Eval.where(@portfolio_id), @eval)
        @another_avg_eval.update(avg_params)
        expect(@another_avg_eval).to be_valid
      end
    end
  end
end
