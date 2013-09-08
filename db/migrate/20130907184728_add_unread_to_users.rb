class AddUnreadToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :unread, :integer
  end
end
