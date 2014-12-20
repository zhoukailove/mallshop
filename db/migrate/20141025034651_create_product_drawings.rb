class CreateProductDrawings < ActiveRecord::Migration
  def change
    create_table :product_drawings do |t|
      t.integer :product_id
      t.integer :sort
      t.string :product_drawing

      t.timestamps
    end
  end
end
