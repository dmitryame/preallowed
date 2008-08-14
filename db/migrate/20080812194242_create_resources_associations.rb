class CreateResourcesAssociations < ActiveRecord::Migration
  def self.up
    create_table :resources_associations do |t|
      t.integer :resource_id, :null => false
      t.integer :role_id, :null => false

      t.timestamps
    end
    
    add_index :resources_associations, :resource_id
    add_index :resources_associations, :role_id 
    
  end

  def self.down
    remove_index :resources_associations, :resource_id
    remove_index :resources_associations, :role_id    
    
    drop_table :resources_associations
  end
end
