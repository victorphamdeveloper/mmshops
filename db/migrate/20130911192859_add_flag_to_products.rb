class AddFlagToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :flag, :integer
  end
end
