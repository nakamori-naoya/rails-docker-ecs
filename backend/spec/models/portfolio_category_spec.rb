require 'rails_helper'

RSpec.describe PortfolioCategory, type: :model do
  before do
      create_portfolio_category_form
  end

  private
  def create_portfolio_category_form
    @portfolio_category_form = FactoryBot.build(:portfolio_category_form)
    @portfolio_category_form.images = [fixture_file_upload('app/assets/images/github_icon.png'),
                                        fixture_file_upload('app/assets/images/DHH.jpeg')]
    @user = FactoryBot.build(:user)
    @user.save
    @portfolio_category_form.user_id = @user.id
    return @portfolio_category_form
  end

  describe "カテゴリの投稿" do
    context "正常系" do
      it "新規投稿ができる" do
        @portfolio_category_form.save
        expect(@portfolio_category_form).to be_valid
      end
      it "既存のカテゴリと同名のカテゴリが送られてきたときには、新規にカテゴリーが作成されない" do
        @portfolio_category_form.name = "Ruby on Rails"
        @portfolio_category_form.save
        count = Category.count
        @another_portfolio_category_form = create_portfolio_category_form
        @another_portfolio_category_form.name = "Ruby on Rails"
        @another_portfolio_category_form.save
        new_count = Category.count
        expect(count).to eq new_count
      end
    end
  end
end
