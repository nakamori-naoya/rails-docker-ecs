class Portfolio < ApplicationRecord
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
end
