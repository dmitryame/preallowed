  class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.column :name,               :string
      t.references :resource_type, :scope,  :null => false
      t.timestamps 
    end  
    execute 'ALTER TABLE resources ADD CONSTRAINT fk_resources_scope FOREIGN KEY ( scope_id ) REFERENCES scopes(id)'
    execute 'ALTER TABLE resources ADD CONSTRAINT fk_resources_resource_type FOREIGN KEY ( resource_type_id ) REFERENCES resource_types(id)'
  end

  def self.down
    drop_table :resources
  end
end
