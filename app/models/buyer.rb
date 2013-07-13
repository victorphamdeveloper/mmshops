class Buyer < User 
	has_many :line_items, :through => :orders
	has_many :orders
	has_many :liked_items
	has_many :messages
end