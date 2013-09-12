# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  
  
  has_many :products
  #has_many :products, through: :sub_categories
  has_ancestry
  attr_accessible :name, :parent_id

  def get_products
  	products = self.products.all

  	products.to_a
  	self.children.each do |f|
  		products.push f.get_products
  	end
  	products
  end
end
