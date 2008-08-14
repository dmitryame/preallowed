class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.integer :client_id

      t.timestamps
    end
    add_index :roles, :name
    add_index :roles, :client_id
    add_index :roles, [:client_id, :name], :unique => true

  end

  def self.down
    remove_index :roles, :name
    remove_index :roles, :client_id
    remove_index :roles, [:client_id, :name]
    
    drop_table :roles
  end
end
