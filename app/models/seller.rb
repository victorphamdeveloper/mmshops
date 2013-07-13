class Seller < User
	has_one :seller_info
	has_many :products 
	has_many :messages
end