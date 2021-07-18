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
    context "異常系" do
      it "タイトルの記入がないとき" do
        @portfolio_category_form.title = ""
        @portfolio_category_form.valid?

        expect(@portfolio_category_form.errors.full_messages).to include("Titleは1文字以上で入力してください")
      end
      it "タイトルが30文字を超えるとき" do
        @portfolio_category_form.title = @portfolio_category_form.title << "アイウエオ"
        @portfolio_category_form.valid?
        expect(@portfolio_category_form.errors.full_messages).to include("Titleは30文字以内で入力してください")
      end
      it "説明文の記載がないとき" do
        @portfolio_category_form.description = ""
        @portfolio_category_form.valid?
        expect(@portfolio_category_form.errors.full_messages).to include("Descriptionは1文字以上で入力してください")
      end
      it "説明文が400文字を超えるとき" do 
        @portfolio_category_form.description = @portfolio_category_form.description << "アイウエオ"
        @portfolio_category_form.valid?
        expect(@portfolio_category_form.errors.full_messages).to include("Descriptionは400文字以内で入力してください")
      end
      it "WebサイトのURLの記載がないとき" do
        @portfolio_category_form.site_url = ""
        @portfolio_category_form.valid?
        expect(@portfolio_category_form.errors.full_messages).to include("Site urlを入力してください")
      end
      it "GithubのURLの記載がないとき" do
        @portfolio_category_form.github_url = ""
        @portfolio_category_form.valid?
        expect(@portfolio_category_form.errors.full_messages).to include("Github urlを入力してください")
      end
      it "画像の添付がないとき" do
        @non_image_portfolio = FactoryBot.build(:portfolio)
        @non_image_portfolio.valid?
        expect(@non_image_portfolio.errors.full_messages).to include("Imagesを入力してください")
      end
      it "画像としてpng,jpg,jpeg以外のファイルをアップロードした時" do
        @incorrect_image_portfolio = FactoryBot.build(:portfolio)
        @incorrect_image_portfolio.images = [fixture_file_upload('app/assets/images/sample.md')]
        @incorrect_image_portfolio.valid?
        expect(@incorrect_image_portfolio.errors.full_messages).to include("ImagesのContent Typeが不正です")
      end
    end
  end
end
