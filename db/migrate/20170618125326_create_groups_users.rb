class CreateGroupsUsers < ActiveRecord::Migration[5.1]
  def self.up
    create_table :groups_users do |t|
      t.integer :group_id
      t.integer :user_id

      t.timestamps
    end

    add_index :groups_users, :group_id
    add_index :groups_users, :user_id
  end

  def self.down
    drop_table :groups_users
  end
end
