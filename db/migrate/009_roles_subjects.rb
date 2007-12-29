class RolesSubjects < ActiveRecord::Migration
  def self.up
    create_table :roles_subjects, :id => false do |t|
      t.references :role, :subject, :null => false
      t.timestamps 
    end
    
    add_index :roles_subjects, [ :role_id, :subject_id ]
    add_index :roles_subjects, :subject_id 
    
    execute 'ALTER TABLE roles_subjects ADD CONSTRAINT fk_roles_subjects_role FOREIGN KEY ( role_id ) REFERENCES roles(id)'
    execute 'ALTER TABLE roles_subjects ADD CONSTRAINT fk_roles_subjects_subject FOREIGN KEY ( subject_id ) REFERENCES subjects(id)'

    admin = Subject.create :name => "admin", :client_id => 1
    admin.save!
    adminsPasswordPrincipal = 
        Principal.create :value => "35263a0f3aa0ea37b57027d3c9635725746644e3", 
        :principal_type_id      => 1, 
        :subject_id             => admin.id
    adminsPasswordPrincipal.save!
    adminsSaltPrincipal     = 
        Principal.create :value => "291247300.585749468074609", 
        :principal_type_id      => 2, 
        :subject_id             => admin.id
    adminsSaltPrincipal.save!

  end

  def self.down
    drop_table :roles_subjects
  end
end
