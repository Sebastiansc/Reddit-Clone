class CrossPost < ActiveRecord::Base
  validates :sub, :post, presence: true

  belongs_to :sub, inverse_of: :cross_posts
  belongs_to :post, inverse_of: :cross_posts

end
