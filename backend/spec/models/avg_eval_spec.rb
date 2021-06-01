require 'rails_helper'

RSpec.describe AvgEval, type: :model do
  before do 
    @eval = FactoryBot.build(:eval)
    @eval.save
    @portfolio_id = {portfolio_id: @eval.portfolio_id}
  end
  describe "ポートフォリオの評価の投稿" do
    context "正常系" do
      it "評価が初めて投稿された場合" do
        binding.pry 
        AvgEval.calcurate(@portfolio_id, Eval.where(@portfolio_id), @eval)
      end
    end
  end
end
