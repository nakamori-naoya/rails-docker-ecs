require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  #user = User.new(email: '', password: 'nigg1994', password_confirmation: 'nigg1994')
  #更新系として、パスワードやメールアドレスの変更があるが、これはいったん考えずに追加の実装に回す。
  describe 'ユーザー新規登録' do
    context "新規登録ができないとき(異常系)" do
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it "パスワードが空では登録できない" do
        @user.password_digest = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it "パスワードが6文字未満では登録できない" do
        @user.password = "12345"
        @user.valid?  
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it "パスワードが数字のみの場合登録できない" do
        @user.password = "12345678"
        @user.valid?   
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it "パスワードが英字のみの場合登録できない" do
        @user.password = "abcdefg"
        @user.valid?   
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
    end
    context "新規登録ができるとき(正常系)" do
      it "メールアドレスとパスワードが入力されていれば登録できる" do
        expect(@user).to be_valid
      end
    end
  end
end
