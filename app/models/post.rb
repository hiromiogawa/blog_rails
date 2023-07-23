class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true
  validates :user, presence: true
  validates :category, presence: true
end
