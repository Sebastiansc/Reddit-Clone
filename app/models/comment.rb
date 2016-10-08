class Comment < ActiveRecord::Base
  validates :content, :author, :post, presence: true

  belongs_to :post, inverse_of: :comments
  belongs_to :author, class_name: :User, inverse_of: :comments
  belongs_to :parent, class_name: :Comment, foreign_key: :parent_id

  has_many :child_comments,
   foreign_key: :parent_id,
   class_name: :Comment

end
