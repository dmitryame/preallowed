class CreateSubjectsAssociations < ActiveRecord::Migration
  def self.up
    create_table :subjects_associations do |t|
      t.integer :subject_id
      t.integer :role_id

      t.timestamps
    end
    
    add_index :subjects_associations, :subject_id 
    add_index :subjects_associations, :role_id 

  end

  def self.down
    remove_index :subjects_associations, :subject_id
    remove_index :subjects_associations, :role_id

    drop_table :subjects_associations
  end
end
