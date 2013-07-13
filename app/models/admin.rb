class Admin < User
	before_save :set_role

	def set_role
		self.role = 1
	end
end