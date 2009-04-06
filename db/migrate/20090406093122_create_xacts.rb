class CreateXacts < ActiveRecord::Migration
  def self.up
    create_table :xacts do |t|
      t.date :date
      t.integer :user_id
      t.integer :qty
      t.integer :total

      t.timestamps
    end
  end

  def self.down
    drop_table :xacts
  end
end
