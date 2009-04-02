class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :type_id
      t.date :date
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
