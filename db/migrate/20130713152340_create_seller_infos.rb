class CreateSellerInfos < ActiveRecord::Migration
  def change
    create_table :seller_infos do |t|
      t.integer :user_id
      t.text :location
      t.integer :no_of_likes

      t.timestamps
    end
  end
end
