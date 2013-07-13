class Product < ActiveRecord::Base
  belongs_to :seller, class_name: "Seller", foreign_key: :user_id
  belongs_to :category	
  has_many :line_items

  attr_accessible :category_id, :description, :name, :no_of_likes, :price, :user_id
end
