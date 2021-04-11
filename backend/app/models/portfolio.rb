class Portfolio < ApplicationRecord
    validates :name, presence: true, length: { maximum: 24 }   
    validates :nickName,  length: { maximum: 16 }   

end
