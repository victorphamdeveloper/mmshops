# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  role            :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  
  before_create :set_default_role, :create_remember_token	
  before_save { |user| user.email = email.downcase }
  
  attr_accessible :email, :name, :password, :password_confirmation, :role, :seller_level, :ban, :unread
  has_secure_password 

  has_many :sended_conversations, class_name: "Conversation", foreign_key: :sender_id
  has_many :received_conversations, class_name: "Conversation", foreign_key: :receiver_id

  has_many :likes, foreign_key: "user_id"
  has_many :like_products, class_name: "Product", through: :likes, source: "product"


  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true


  def set_default_role
  	# unless user's role is admin (default value = 1)
  	# user is buyer (value = 3)
  	if self.role == nil 
  		self.role = 3 
  	end
    ban = 0
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
