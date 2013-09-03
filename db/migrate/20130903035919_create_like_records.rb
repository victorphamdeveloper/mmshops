class CreateLikeRecords < ActiveRecord::Migration
  def change
    create_table :like_records do |t|
      t.integer :user_id
      t.string :product_id
      t.string :integer

      t.timestamps
    end
  end
end
