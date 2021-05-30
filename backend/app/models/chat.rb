class Chat < ApplicationRecord
    belongs_to :user
    belongs_to :portfolio
    validates :text, presence: true
end
