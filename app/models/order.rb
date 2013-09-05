# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  price          :decimal(, )
#  address        :text
#  payment_method :string(255)
#  status         :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Order < ActiveRecord::Base
  belongs_to :buyer, class_name: "Buyer"
  belongs_to :seller, class_name: "Seller"
  has_many :line_items
  
  attr_accessible :address, :payment_method, :price, :status, :user_id
end
