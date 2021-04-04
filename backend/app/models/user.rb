class User < ApplicationRecord

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?[\d])\w{8,12}\z/
    #英小文字と数字で8~12文字
    validates :email, presense: true, format: { with: VALID_EMAIL_REGEX }
    validates :password_digest, presense: true , format: { with: VALID_PASSWORD_REGEX }
end
