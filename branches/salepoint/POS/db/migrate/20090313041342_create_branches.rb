class CreateBranches < ActiveRecord::Migration
  def self.up
    create_table :branches do |t|
      t.string :branch_name
      t.string :branch_address

      t.timestamps
    end
  end

  def self.down
    drop_table :branches
  end
end
