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

	def role_title(role)
		if role == 2
			"Seller"
		elsif role == 3
			"Buyer" 
		elsif role == 1
			"Admin"
		end
	end
	
	def current_cart
		Cart.find(session[:cart_id])
		rescue ActiveRecord::RecordNotFound
		cart = Cart.create
		session[:cart_id] = cart.id
		cart
	end
	
	def filter_ban
		unless current_user.ban == 0
      redirect_to root_url, notice: "Your account is banned! Contact the administrator for more information"
    end
	end

	def filter_ban_product()
		product = Product.find(params[:id])
		unless product.ban == 0
			redirect_to root_url, notice: "This product is banned! Contact the administrator for more information"
		end
	end

	def is_buyer(user)
		user != nil and user.role == 3
	end

	def is_admin(user)
		user != nil and user.role == 1 
	end
	
	def is_seller(user)
		user != nil and user.role == 2
	end

	def is_seller_of(product)
		current_user != nil and product.user_id == current_user.id 
	end

	def total_likes(user)
    	if is_seller(user)
    			user = user.becomes(Seller)
      		result = 0
      		user.products.each do |p|
        	result += p.likes.count 
      		end
      		result
    	end
  	end

end
