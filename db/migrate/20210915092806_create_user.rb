class CreateUser < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, :null => false, :default => ""
      t.string :password, :null => false, :default => ""
      t.timestamps
    end
    add_index :users, :name, :unique => true
  end
end
