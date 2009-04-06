class CreateProductBranches < ActiveRecord::Migration
  def self.up
    create_table :product_branches do |t|
      t.integer :product_id
      t.integer :branch_id
      t.integer :stock

      t.timestamps
    end
  end

  def self.down
    drop_table :product_branches
  end
end
