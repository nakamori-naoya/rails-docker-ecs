class Profile < ApplicationRecord
  validates :nickname, presence: true, length: { in: 1..20 }, uniqueness: {case_sensitive: true}
  validates :self_introduction,  length: { in: 0..400 }
  validates :programming_start_date, presence: true
  validates :image, 
    attached: true,   #添付がマストになる。   画像投稿のバリデーションは共通するので切り出そう
    content_type: [:png,:jpg,:jpeg],
    size:{less_than_or_equal_to:10.megabytes},
    dimension:{width:{max:2000},height:{max:2000}, message: 'is not given between dimension'}
  belongs_to :user
  has_one_attached :image
end
