# == Schema Information
#
# Table name: liked_items
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LikedItem < ActiveRecord::Base
  belongs_to :buyer, class_name: "Buyer", foreign_key: :user_id
  attr_accessible :product_id, :user_id
end
