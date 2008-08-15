class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.string :name, :null => false
      t.references :client, :null => false

      t.timestamps
    end
    add_index :resources, :name
    add_index :resources, :client_id
    add_index :resources, [:client_id, :name], :unique => true
    

  end

  def self.down
    remove_index :resources, :name
    remove_index :resources, :client_id
    remove_index :resources, [:client_id, :name]
    
    drop_table :resources
  end
end
