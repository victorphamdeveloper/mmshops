class Buyer < User 
	before_save :set_role

	has_many :line_items, :through => :orders
	has_many :orders, foreign_key: :user_id 
	has_many :liked_items, foreign_key: :user_id

	def set_role
		self.role = 3
	end
end