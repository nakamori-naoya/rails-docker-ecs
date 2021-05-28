require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "カテゴリの付与" do
    before do
      @category = FactoryBot.build(:category)
    end
    context "カテゴリの付与ができないとき" do
      it "名前がないとき" do
        @portfolio.valid?
        expect(@portfolio.errors.full_messages).to include("Titleは1文字以上で入力してください")
      end
      
    end
  end
end
