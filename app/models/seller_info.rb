# == Schema Information
#
# Table name: seller_infos
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  location    :text
#  no_of_likes :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SellerInfo < ActiveRecord::Base
  belongs_to :seller, class_name: "Seller", foreign_key: :user_id 

  attr_accessible :location, :no_of_likes, :user_id
end
