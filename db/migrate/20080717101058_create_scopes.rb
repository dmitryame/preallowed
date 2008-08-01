class CreateScopes < ActiveRecord::Migration
  def self.up
    create_table :scopes do |t|
      t.references  :client,  :null => false      
      t.column :name,       :string      
      t.timestamps 
    end
    
    execute 'ALTER TABLE scopes ADD CONSTRAINT fk_scopes_client 
                                    FOREIGN KEY ( client_id ) REFERENCES clients(id)'

  end

  def self.down
    drop_table :scopes
  end
end
