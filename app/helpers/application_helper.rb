module ApplicationHelper
	#Returns the full title on a per-page basis
	def full_title(page_title)
		base_title = "MmShops"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end


	def current_cart
		Cart.find(session[:cart_id])
		rescue ActiveRecord::RecordNotFound
		cart = Cart.create
		session[:cart_id] = cart.id
		cart
	end
	
	def is_buyer(user)
		user.role == 3
	end

	def is_admin(user)
		user.role == 1
	end
	
	def is_seller(user)
		user.role == 2
	end

	def total_likes(user)
    	if is_seller(user)
      		result = 0
      		user.products.each do |p|
        	result += p.likes.count 
      		end
      		result
    	end
  	end
end
