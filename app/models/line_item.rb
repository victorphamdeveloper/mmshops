class LineItem < ActiveRecord::Base
  attr_accessible :order_id, :product_id, :quantity, :status
end
