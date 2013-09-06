class AddBuyerAndSellerIdToLineItems < ActiveRecord::Migration
  def change
  	add_column :line_items, :seller_id, :integer
  	add_column :line_items, :buyer_id, :integer
  end
end
