class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :line_items
  
  def add_product(product_id, seller_id, buyer_id)
		current_item = line_items.find_by_product_id(product_id)
		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(:product_id => product_id, quantity: 1, seller_id: seller_id, buyer_id: buyer_id)
		end
		current_item
	end

	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end

end
