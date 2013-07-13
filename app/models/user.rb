class User < ActiveRecord::Base
  before_save :set_default_role	
 
  attr_accessible :email, :name, :password_digest, :role

  has_many :sended_messages, class_name: "Message", foreign_key: :sender_id, dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: :receiver_id

  def set_default_role
  	# unless user's role is admin (default value = 1)
  	# user is buyer (value = 3)
  	if self.role != nil
  		self.role = 3 
  	end
  end
end
