class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.string :name       
      t.references :client, :null => false
      t.timestamps 
    end
    execute 'ALTER TABLE subjects ADD CONSTRAINT fk_subjects_client FOREIGN KEY ( client_id ) REFERENCES clients(id)'

    Subject.create(:id =>1, :name => "admin", :client_id => 1).save!
    
  end

  def self.down
    drop_table :subjects
  end
end
