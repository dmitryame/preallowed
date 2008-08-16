class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name, :null => false
      t.boolean :preallowed, :null => false, :default => false
      
      t.timestamps
    end
    add_index :clients, :name
    add_index :clients, :preallowed
  end

  def self.down
    remove_index :clients, :name
    remove_index :clients, :preallowed
        
    drop_table :clients
  end
end
