require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  before do
    @portfolio = FactoryBot.build(:portfolio)
    @portfolio.images = [fixture_file_upload('app/assets/images/github_icon.png'),
                          fixture_file_upload('app/assets/images/DHH.jpeg')]
  end

  describe "ポートフォリオの投稿" do
    context "ポートフォリオの投稿ができないとき(異常系)" do
      it "タイトルの記入がないとき" do
        @portfolio.title = ""
        @portfolio.valid?
        expect(@portfolio.errors.full_messages).to include("Titleは1文字以上で入力してください")
      end
      it "タイトルが30文字を超えるとき" do
        @portfolio.title = @portfolio.title << "アイウエオ"
        @portfolio.valid?
        expect(@portfolio.errors.full_messages).to include("Titleは30文字以内で入力してください")
      end
      it "説明文の記載がないとき" do
        @portfolio.description = ""
        @portfolio.valid?
        expect(@portfolio.errors.full_messages).to include("Descriptionは1文字以上で入力してください")
      end
      it "説明文が400文字を超えるとき" do 
        @portfolio.description = @portfolio.description << "アイウエオ"
        @portfolio.valid?
        expect(@portfolio.errors.full_messages).to include("Descriptionは400文字以内で入力してください")
      end
      it "WebサイトのURLの記載がないとき" do
        @portfolio.site_url = ""
        @portfolio.valid?
        expect(@portfolio.errors.full_messages).to include("Site urlを入力してください")
      end
      it "GithubのURLの記載がないとき" do
        @portfolio.github_url = ""
        @portfolio.valid?
        expect(@portfolio.errors.full_messages).to include("Github urlを入力してください")
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
