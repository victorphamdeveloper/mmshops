# == Schema Information
#
# Table name: line_items
#
#  id         :integer          not null, primary key
#  product_id :integer
#  order_id   :integer
#  status     :string(255)
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LineItem < ActiveRecord::Base
  belongs_to :order	
  belongs_to :product
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"
  belongs_to :cart

  attr_accessible :product_id, :quantity, :status, :cart_id, :buyer_id, :seller_id
  def total_price
  	product.price * quantity
  end

end
