class CreateXactDetails < ActiveRecord::Migration
  def self.up
    create_table :xact_details do |t|
      t.integer :xact_id
      t.integer :product_id
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end

  def self.down
    drop_table :xact_details
  end
end
