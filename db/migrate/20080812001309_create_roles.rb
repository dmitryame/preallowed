class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.integer :client_id

      t.timestamps
    end
    add_index :roles, :name
    add_index :roles, :client_id

  end

  def self.down
    remove_index :roles, :name
    remove_index :roles, :client_id
    
    drop_table :roles
  end
end
