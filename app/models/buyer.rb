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

class Buyer < User 
	before_save :set_role

	has_many :line_items, :through => :orders
	has_many :orders, foreign_key: :user_id 
	

	def set_role
		self.role = 3
	end
end
