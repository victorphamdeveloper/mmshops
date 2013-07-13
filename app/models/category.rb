class Category < ActiveRecord::Base
  belongs_to :parent_category, class_name: "Category"
  has_many :sub_categories, class_name: "Category", foreign_key: :parent_id
  has_many :products
  #has_many :products, through: :sub_categories

  attr_accessible :name, :parent_id

  def get_products
  	products = self.products.all

  	products.to_a
  	self.sub_categories.each do |f|
  		products.push f.get_products
  	end
  	products
  end
end
