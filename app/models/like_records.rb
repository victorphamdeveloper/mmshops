class LikeRecords < ActiveRecord::Base
  attr_accessible :integer, :product_id, :user_id
end
