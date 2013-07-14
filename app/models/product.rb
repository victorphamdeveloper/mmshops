# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  category_id :integer
#  name        :string(255)
#  price       :decimal(, )
#  description :text
#  no_of_likes :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ActiveRecord::Base
  belongs_to :seller, class_name: "Seller", foreign_key: :user_id
  belongs_to :category	
  has_many :line_items

  attr_accessible :category_id, :description, :name, :no_of_likes, :price, :user_id
end
