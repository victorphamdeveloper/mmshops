class LineItem < ActiveRecord::Base
  belongs_to :order	
  belongs_to :product
  belongs_to :seller
  belongs_to :buyer

  attr_accessible :order_id, :product_id, :quantity, :status
end
