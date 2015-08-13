class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.string :password
      t.datetime :created_at
    end
    add_index :accounts, :name, :unique => true
  end

  def self.down
    drop_table :accounts
  end
end
