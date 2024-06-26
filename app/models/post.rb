class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, :body, presence: true
  validates :title, length: { in: 4..30 }
  validates :body, length: { maximum: 100 }
end
