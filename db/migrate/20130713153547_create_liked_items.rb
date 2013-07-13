class CreateLikedItems < ActiveRecord::Migration
  def change
    create_table :liked_items do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
  end
end
