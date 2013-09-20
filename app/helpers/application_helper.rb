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
		if role == 3
			"User" 
		elsif role == 1
			"Admin"
		end
	end

	def city_filter()
		if current_user != nil
			cookies[:location] ||= current_user.location
		else
			cookies[:location] ||= "Yangon"
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

	def filter_admin
		unless is_admin(current_user)
			redirect_to root_url, notice: "You must be admin to view this"
		end
	end
	
	def is_admin(user)
		user != nil and user.role == 1 
	end

	def is_seller_of(product)
		current_user != nil and product.user_id == current_user.id 
	end

	def total_likes(user)
    result = 0
    user.products.each do |p|
      result += p.likes.count 
    end
    result  	
  end

end
