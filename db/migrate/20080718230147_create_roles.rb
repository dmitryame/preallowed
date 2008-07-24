class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.column :name,       :string
      t.references :client,  :null => false
      t.timestamps 
    end
    execute 'ALTER TABLE roles ADD CONSTRAINT fk_roles_client FOREIGN KEY ( client_id ) REFERENCES clients(id)'
    
    Role.create(:id => 1, :name => "preallowed_admin", :client_id => 1).save!
    
  end

  def self.down
    drop_table :roles
  end
end
