class CreateScopes < ActiveRecord::Migration
  def self.up
    create_table :scopes do |t|
      t.column :name,       :string
      t.column :client_id,  :integer,   :null => false
      t.column :created_at, :datetime,  :null => false
      t.column :updated_at, :datetime,  :null => false
    end
    
    execute 'ALTER TABLE scopes ADD CONSTRAINT fk_scopes_client 
                                FOREIGN KEY ( client_id ) REFERENCES clients(id)'
  end

  def self.down
    drop_table :scopes
  end
end
