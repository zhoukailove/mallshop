class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.integer :user_id
      t.boolean :state
      t.string :barcode
      t.integer :orders_count
      t.integer :comments_count
      t.text :synopsis

      t.timestamps
    end
  end
end
