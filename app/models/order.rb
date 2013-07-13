class Order < ActiveRecord::Base
  attr_accessible :address, :payment_method, :price, :status, :user_id
end
