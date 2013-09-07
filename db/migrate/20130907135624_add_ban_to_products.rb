class AddBanToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :ban, :integer
  end
end
