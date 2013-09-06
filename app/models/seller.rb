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

class Seller < User
	before_save :set_role

	has_one :seller_info, foreign_key: :user_id 
	accepts_nested_attributes_for :seller_info

	has_many :products, foreign_key: :user_id, dependent: :destroy
	has_many :line_items,foreign_key: :seller_id 
	has_many :orders, foreign_key: :seller_id

	def set_role
		self.role = 2
		self.seller_level = 'normal'
	end
end
