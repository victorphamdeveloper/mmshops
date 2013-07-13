class LikedItem < ActiveRecord::Base
  belongs_to :buyer, class_name: "Buyer", foreign_key: :user_id
  attr_accessible :product_id, :user_id
end
