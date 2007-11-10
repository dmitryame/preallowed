class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.column :name,       :string
      t.column :client_id,  :integer,   :null => false
      t.column :created_at, :datetime,  :null => false
      t.column :updated_at, :datetime,  :null => false
    end
    execute 'ALTER TABLE subjects ADD CONSTRAINT fk_subjects_client FOREIGN KEY ( client_id ) REFERENCES clients(id)'
  end

  def self.down
    drop_table :subjects
  end
end
