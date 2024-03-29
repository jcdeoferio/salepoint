class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :userid
      t.string :role
      t.string :first_name
      t.string :last_name
      t.integer :branch_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
