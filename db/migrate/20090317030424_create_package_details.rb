class CreatePackageDetails < ActiveRecord::Migration
  def self.up
    create_table :package_details do |t|
      t.integer :package_id
      t.integer :product_id

      t.timestamps
    end
  end

  def self.down
    drop_table :package_details
  end
end
