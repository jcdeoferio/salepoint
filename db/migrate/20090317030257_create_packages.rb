class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.string :package_name

      t.timestamps
    end
  end

  def self.down
    drop_table :packages
  end
end
