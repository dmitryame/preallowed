class ResourcesRoles < ActiveRecord::Migration
  def self.up
    create_table :resources_roles, :id => false do |t|
      t.column :resource_id,  :integer,   :null => false
      t.column :role_id,        :integer,   :null => false
      t.column :created_at,     :datetime,  :null => false
      t.column :updated_at,     :datetime,  :null => false
    end
    
    add_index :resources_roles, [ :resource_id, :role_id ]
    
    execute 'ALTER TABLE resources_roles ADD CONSTRAINT fk_resources_roles_resource FOREIGN KEY ( resource_id ) REFERENCES resources(id)'
    execute 'ALTER TABLE resources_roles ADD CONSTRAINT fk_resources_roles_role FOREIGN KEY ( role_id ) REFERENCES roles(id)'
    
  end

  def self.down
    drop_table :resources_roles
  end
end
