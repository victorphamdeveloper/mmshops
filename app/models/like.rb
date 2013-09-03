class Like < ActiveRecord::Base
  attr_accessible :product_id, :user_id

  belongs_to :product
  belongs_to :user

  validates :product_id, presence: true
  validates :user_id, presence: true
end
