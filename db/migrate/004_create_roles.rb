class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.column :name,       :string
      t.references :client,  :null => false
      t.timestamps 
    end
    execute 'ALTER TABLE roles ADD CONSTRAINT fk_roles_client FOREIGN KEY ( client_id ) REFERENCES clients(id)'
  end

  def self.down
    drop_table :roles
  end
end
