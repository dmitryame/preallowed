class CreateLogRecords < ActiveRecord::Migration
  def self.up
    create_table :log_records do |t|
      t.column :subject_id,       :integer,   :null => false
      t.column :scope_id,         :integer,   :null => false
      t.column :resource_id,    :integer,   :null => false
      t.column :granted,          :boolean
      t.column :notes,            :string
      t.column :created_at,       :datetime,  :null => false
      t.column :updated_at,       :datetime,  :null => false
    end
    
    execute 'ALTER TABLE log_records ADD CONSTRAINT fk_log_records_subject FOREIGN KEY ( subject_id ) REFERENCES subjects(id)'
    execute 'ALTER TABLE log_records ADD CONSTRAINT fk_log_records_scope FOREIGN KEY ( scope_id ) REFERENCES scopes(id)'
    execute 'ALTER TABLE log_records ADD CONSTRAINT fk_log_records_resource FOREIGN KEY ( resource_id ) REFERENCES resources(id)'
    
    
  end

  def self.down
    drop_table :log_records
  end
end
