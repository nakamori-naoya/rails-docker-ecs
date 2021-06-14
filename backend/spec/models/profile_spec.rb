require 'rails_helper'

RSpec.describe Profile, type: :model do
  before do
    @profile = FactoryBot.build(:profile)
    @profile.image = fixture_file_upload('app/assets/images/github_icon.png')
  end

  describe "プロフィールの新規作成" do
    context "プロフィールが登録できないとき(異常系)" do
      it "ニックネームが空のとき" do
        @profile.nickname = ""
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Nicknameは1文字以上で入力してください")
      end
      it "ニックネームが重複したとき" do
        @profile.save
        another_profile = FactoryBot.build(:profile)
        another_profile.nickname = @profile.nickname
        another_profile.valid?
        expect(another_profile.errors.full_messages).to include("Nicknameはすでに存在します")
      end
      it "ニックネームが20文字より大きいとき" do
        @profile.nickname = "abcdefg123456789123456789"
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Nicknameは20文字以内で入力してください")
      end
      it "説明文が400文字を超えるとき" do
        @profile.self_introductionn = @profile.self_introductionn.concat("Hello World")
        @profile.valid?
        expect(@profile.errors.full_messages).to include("SelfIntroductionnは400文字以内で入力してください")
      end
      it "画像の添付がされていない時" do
        @non_image_profile = FactoryBot.build(:profile)
        @non_image_profile.valid?
        expect(@non_image_profile.errors.full_messages).to include("Imageを入力してください")
      end
      it "画像としてpng,jpg,jpeg以外のファイルをアップロードした時" do
        @profile.image = fixture_file_upload('app/assets/images/sample.md')
        @profile.valid?
        expect(@profile.errors.full_messages).to include("ImageのContent Typeが不正です")
      end
    end

    context "プロフィールが登録できるとき(正常系)" do
      it "ニックネームとプログラミング開始月の入力と画像の添付があれば投稿できる" do
        @profile.self_introductionn = ""
        @profile.web_site_url = ""  
        expect(@profile).to be_valid
      end
    end
  end
  
  describe "プロフィールの更新" do
    context "プロフィールが投稿できないとき(異常系)" do
      it "ニックネームが空のとき" do
        
      end
      it "ニックネームが重複したとき" do
        
      end
      it "ニックネームが20文字以上のとき" do
        
      end
    
    end

    context "プロフィールが投稿できるとき(正常系)" do
    end
  end

  
end
