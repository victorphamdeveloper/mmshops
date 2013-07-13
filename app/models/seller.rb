class Seller < User
	before_save :set_role

	has_one :seller_info
	has_many :products 
	has_many :messages

	def set_role
		self.role = 2
	end
end