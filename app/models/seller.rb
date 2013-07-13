class Seller < User
	before_save :set_role

	has_one :seller_info, foreign_key: :user_id 
	has_many :products, foreign_key: :user_id
	has_many :line_items, through: :products

	def set_role
		self.role = 2
	end
end