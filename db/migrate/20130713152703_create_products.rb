class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :name
      t.decimal :price
      t.text :description
      t.integer :no_of_likes

      t.timestamps
    end
  end
end
