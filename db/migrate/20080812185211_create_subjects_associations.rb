class CreateSubjectsAssociations < ActiveRecord::Migration
  def self.up
    create_table :subjects_associations do |t|
      t.references :subject, :null => false
      t.references :role, :null => false

      t.timestamps
    end
    
    add_index :subjects_associations, :subject_id 
    add_index :subjects_associations, :role_id 
    add_index :subjects_associations, [:role_id, :subject_id], :unique => true 

  end

  def self.down
    remove_index :subjects_associations, :subject_id
    remove_index :subjects_associations, :role_id
    remove_index :subjects_associations, [:role_id, :subject_id]

    drop_table :subjects_associations
  end
end
