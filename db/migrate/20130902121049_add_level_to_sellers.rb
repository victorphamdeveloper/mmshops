class AddLevelToSellers < ActiveRecord::Migration
  def change
  	add_column :users, :seller_level, :string
  end
end
