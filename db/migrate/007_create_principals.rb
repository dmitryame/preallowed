class CreatePrincipals < ActiveRecord::Migration
  def self.up
    create_table :principals do |t|
      t.column :value,              :string
      t.references :principal_type, :subject,   :null => false
      t.timestamps 
    end
    execute 'ALTER TABLE principals ADD CONSTRAINT fk_principals_subject FOREIGN KEY ( subject_id ) REFERENCES subjects(id)'
    execute 'ALTER TABLE principals ADD CONSTRAINT fk_principals_principal_type FOREIGN KEY ( principal_type_id ) REFERENCES principal_types(id)'

    
  end

  def self.down
    drop_table :principals
  end
end
