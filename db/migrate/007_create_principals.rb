class CreatePrincipals < ActiveRecord::Migration
  def self.up
    create_table :principals do |t|
      t.column :value,              :string
      t.references :principal_type, :subject,   :null => false
      t.timestamps 
    end
    execute 'ALTER TABLE principals ADD CONSTRAINT fk_principals_subject FOREIGN KEY ( subject_id ) REFERENCES subjects(id)'
    execute 'ALTER TABLE principals ADD CONSTRAINT fk_principals_principal_type FOREIGN KEY ( principal_type_id ) REFERENCES principal_types(id)'

    adminsPasswordPrincipal = 
        Principal.create :value => "35263a0f3aa0ea37b57027d3c9635725746644e3", 
        :principal_type_id      => 1, 
        :subject_id             => 1
    adminsPasswordPrincipal.save!
    adminsSaltPrincipal     = 
        Principal.create :value => "291247300.585749468074609", 
        :principal_type_id      => 2, 
        :subject_id             => 1
    adminsSaltPrincipal.save!

    
  end

  def self.down
    drop_table :principals
  end
end
