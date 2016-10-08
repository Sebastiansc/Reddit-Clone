class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true

  belongs_to :moderator, class_name: "User"

  has_many :cross_posts
  has_many :posts, through: :cross_posts
end
