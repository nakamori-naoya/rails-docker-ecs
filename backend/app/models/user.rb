class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?[\d])\w{8,12}\z/
    #英小文字と数字で8~12文字
    has_one_attached :image
    has_secure_password
    has_many :portfolios, dependent: :destroy
    has_many :evals
    
    validates :nickName,  length: { maximum: 16 }  
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, on: :create
    validates :email, format: { with: VALID_EMAIL_REGEX }, on: :update, allow_blank: true 
    validates :password, presence: true , format: { with: VALID_PASSWORD_REGEX }, on: :create
    validates :password, format: { with: VALID_PASSWORD_REGEX }, on: :update, allow_blank: true
end
