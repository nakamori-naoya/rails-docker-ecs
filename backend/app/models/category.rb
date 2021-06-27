class Category < ApplicationRecord
  has_many :portfolio_categories 
  has_many :portfolios, through: :portfolio_categories 
  validates :name, presence: true,  uniqueness: true   #case_sensitiveについてはこちらを参照：https://qiita.com/jnchito/items/e23b1facc72bd86234b6
  
end


