class RolesSubjects < ActiveRecord::Migration
  def self.up
    create_table :roles_subjects, :id => false do |t|
      t.column :role_id,      :integer,   :null => false
      t.column :subject_id,   :integer,   :null => false
      t.column :created_at,   :datetime,  :null => false
      t.column :updated_at,   :datetime,  :null => false
    end
    
    add_index :roles_subjects, [ :role_id, :subject_id ]
    
    execute 'ALTER TABLE roles_subjects ADD CONSTRAINT fk_roles_subjects_role FOREIGN KEY ( role_id ) REFERENCES roles(id)'
    execute 'ALTER TABLE roles_subjects ADD CONSTRAINT fk_roles_subjects_subject FOREIGN KEY ( subject_id ) REFERENCES subjects(id)'
    
  end

  def self.down
    drop_table :roles_subjects
  end
end
