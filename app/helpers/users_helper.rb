module UsersHelper
	def is_buyer(user)
		user.role == 3
	end

	def is_admin(user)
		user.role == 1
	end
	
	def is_seller(user)
		user.role == 2
	end
end
