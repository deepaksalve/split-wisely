class CreateTransactions < ActiveRecord::Migration[5.1]
  def self.up
    create_table :transactions do |t|
      t.integer :group_id
      t.integer :user_id
      t.date    :date
      t.decimal :amount
      t.decimal :amount_paid

      t.timestamps
    end

    add_index :transactions, :group_id
    add_index :transactions, :user_id
  end

  def self.down
    drop_table :transactions
  end
end
