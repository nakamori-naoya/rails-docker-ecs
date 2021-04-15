class Portfolio < ApplicationRecord
    validates :name, presence: true, length: { maximum: 30 }   
    validates :background_of_creation ,  length: { maximum: 400 }   
    validates :remarkable_point,  length: { maximum: 400 }  
    validates :future_issue ,  length: { maximum: 400 }  
    validates :url, presence: true
    has_many_attached :images
    belongs_to :user
    has_many :evals, dependent: :destroy
    has_one :avg_eval, dependent: :destroy
end
