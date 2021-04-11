class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?[\d])\w{8,12}\z/
    #英小文字と数字で8~12文字
    has_secure_password
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    validates :nickName,  length: { maximum: 16 }   
    validates :password, presence: true , format: { with: VALID_PASSWORD_REGEX }
end
