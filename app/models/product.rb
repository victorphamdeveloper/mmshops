class Product < ActiveRecord::Base
  attr_accessible :category_id, :description, :name, :no_of_likes, :price, :user_id
end
