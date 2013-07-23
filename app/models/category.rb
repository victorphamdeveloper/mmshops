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
  has_ancestry 

  has_many :products

  attr_accessible :name

  def get_products
  	products = self.products.all

  	products.to_a
  	self.children.each do |f|
  		products.push f.get_products
  	end
  	products
  end
end
