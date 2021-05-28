class Portfolio < ApplicationRecord
    validates :title, presence: true, length: { in: 1..30 }
    validates :description , presence: true, length: { in: 1..400 }
    validates :site_url, presence: true
    validates :github_url, presence: true
    validates :images, 
        attached: true,   #添付がマストになる。   EachValidatorで切り出したいが。。。。
        content_type:[:png,:jpg,:jpeg],
        size:{less_than_or_equal_to:10.megabytes},
        dimension:{width:{max:2000},height:{max:2000}, message: 'is not given between dimension'}

    has_many_attached :images
    belongs_to :user
    has_many :chats, dependent: :destroy
    has_many :evals, dependent: :destroy
    has_one :avg_eval, dependent: :destroy
    has_many :portfolio_categories
    has_many :categories, through: :portfolio_categories


    def self.matched_portfolios(ids)
        array = []
        ids.map{ |id|
            array.push(self.find(id)) 
            } 
        return array
    end
end
