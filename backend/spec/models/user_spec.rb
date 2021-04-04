require 'rails_helper'

RSpec.describe User, type: :model do
  describe "パスワード" do
    it '数字が含まれない場合無効になる' do
      user = User.new(password: 'a' * 5)
      user.valid?
      expect(user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります')
    end

    it '英小文字が含まれない場合無効になる' do
      user = User.new(password: '1' * 5)
      user.valid?
      expect(user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります')
    end
  end
end
