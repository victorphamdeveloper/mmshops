class Order < ActiveRecord::Base
  belongs_to :buyer, class_name: "Buyer", foreign_key: :user_id
  has_many :line_items
  
  attr_accessible :address, :payment_method, :price, :status, :user_id
end
