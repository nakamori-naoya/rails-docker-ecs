class Eval < ApplicationRecord
    belongs_to :portfolio
    belongs_to :user

    with_options presence: true do
        validates :sociality, numericality: { in: 0..5 }
        validates :creativity, numericality: { in: 0..5 }
        validates :usability, numericality: { in: 0..5 }
        validates :skill, numericality: { in: 0..5 }
        validates :business_oriented, numericality: { in: 0..5 }
        validates :comprehensive_evaluation , numericality: { in: 0..5 }
    end    

    #evalのsaveのコールバックで行うの全然ありじゃない？？
    
end
