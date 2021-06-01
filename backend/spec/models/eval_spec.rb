require 'rails_helper'

RSpec.describe Eval, type: :model do
  before do 
    @eval = FactoryBot.build(:eval)
    # @eval.portfolio_id = 
  end
  describe "評価の投稿" do
    context "正常系" do
      it "各評価項目が0~5.0の間であれば投稿できる" do
        binding.pry
        expect(@eval).to be_valid
      end
    end
  end
end
