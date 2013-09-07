class AddBanToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :ban, :integer
  end
end
