# == Schema Information
#
# Table name: line_items
#
#  id         :integer          not null, primary key
#  product_id :integer
#  order_id   :integer
#  status     :string(255)
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LineItem < ActiveRecord::Base
  belongs_to :order	
  belongs_to :product
  belongs_to :seller
  belongs_to :buyer

  attr_accessible :order_id, :product_id, :quantity, :status
end
