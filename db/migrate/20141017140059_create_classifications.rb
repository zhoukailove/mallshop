class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
      t.string :name
      t.integer :level
      t.integer :upid
      t.boolean :state

      t.timestamps
    end
  end
end
