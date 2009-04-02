class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :product_name
      t.integer :option
      t.integer :unit_price

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
