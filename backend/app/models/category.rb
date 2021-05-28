class Category < ApplicationRecord
  has_many :portfolio_categories 
  has_many :categories, through: :portfolio_categories 
  validates :name, 
      presence: true,  
      uniqueness: {case_sensitive: true},
      length: { maximum: 20 }  


end
