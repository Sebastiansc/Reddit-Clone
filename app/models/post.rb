class Post < ActiveRecord::Base
  validates :title, :subs, :author, presence: true


  has_many :cross_posts
  has_many :subs, through: :cross_posts, source: :sub
  belongs_to :author, class_name: "User", inverse_of: :posts
  has_many :comments, inverse_of: :post

end
