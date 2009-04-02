class CreateOrderDetails < ActiveRecord::Migration
  def self.up
    create_table :order_details do |t|
      t.integer :t_id
      t.integer :product_id
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :order_details
  end
end
