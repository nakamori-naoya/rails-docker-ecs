class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?[\d])\w{6,20}\z/
    #英小文字と数字で6~20文字

    has_secure_password
    validates :password, presence: true , format: { with: VALID_PASSWORD_REGEX}
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: true}   #case_sensitiveについてはこちらを参照：https://qiita.com/jnchito/items/e23b1facc72bd86234b6
    # validates :email, format: { with: VALID_EMAIL_REGEX }, on: :update, allow_blank: true 
    # validates :password, format: { with: VALID_PASSWORD_REGEX }, on: :update, allow_blank: true

    has_many :portfolios, dependent: :destroy
    has_many :evals
    has_many :chats
    has_one :profile
end
