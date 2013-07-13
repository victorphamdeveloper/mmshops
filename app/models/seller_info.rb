class SellerInfo < ActiveRecord::Base
  belongs_to :seller, class_name: "Seller", foreign_key: :user_id 

  attr_accessible :location, :no_of_likes, :user_id
end
