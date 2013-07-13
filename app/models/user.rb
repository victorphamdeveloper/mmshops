class User < ActiveRecord::Base
  before_save :set_default_role	
 
  attr_accessible :email, :name, :password_digest, :role

  def set_default_role
  	# unless user's role is admin
  	if self.role != nil
  		self.role = "Buyer"
  	end
  end
end
