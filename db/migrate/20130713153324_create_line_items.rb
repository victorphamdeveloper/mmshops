class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :product_id
      t.integer :order_id
      t.string :status
      t.integer :quantity

      t.timestamps
    end
  end
end
