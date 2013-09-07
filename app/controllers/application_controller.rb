class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include UsersHelper
  include ProductsHelper
  include ApplicationHelper
  
  def handle_unverified_request
  	sign_out
  	super
  end


  private
  	def current_cart
  		Cart.find(session[:cart_id])
  		rescue ActiveRecord::RecordNotFound
  		cart = Cart.create
  		session[:cart_id] = cart.id
  		cart
  	end
end
