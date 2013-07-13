class Product < ActiveRecord::Base
  belongs_to :seller, class_name: "User"
  belongs_to :category	
  attr_accessible :category_id, :description, :name, :no_of_likes, :price, :user_id
end
