class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.string :name
      t.integer :client_id

      t.timestamps
    end
    add_index :resources, :name
    add_index :resources, :client_id

  end

  def self.down
    remove_index :resources, :name
    remove_index :resources, :client_id
    
    drop_table :resources
  end
end
