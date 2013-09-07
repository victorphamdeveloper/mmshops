module SessionsHelper
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		return @current_user if !@current_user.nil?

		user = User.find_by_remember_token(cookies[:remember_token])
		if !user.nil?
			if user.role == 2
				user = user.becomes(Seller)
			elsif user.role == 1
				user = user.becomes(Admin)
			elsif user.role == 3
				user = user.becomes(Buyer)
			end
		end
		@current_user ||= user
		
	end

	def current_user?(user)
		user.id == current_user.id
	end
	
	def signed_in?
		!current_user.nil?
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url
	end
	
	def signed_in_user
    unless signed_in?
			store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def filter_seller
    unless is_seller(current_user)
      redirect_to root_url, notice: "You must be a seller to do this."
    end
  end

	
end
