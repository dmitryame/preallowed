class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.string :name       
      t.references :client, :null => false
      t.timestamps 
    end
    # execute 'ALTER TABLE subjects ADD CONSTRAINT fk_subjects_client FOREIGN KEY ( client_id ) REFERENCES clients(id)'
  end

  def self.down
    drop_table :subjects
  end
end
