class CreateLogRecords < ActiveRecord::Migration
  def self.up
    create_table :log_records do |t|
      t.references :subject, :scope, :resource, :null => false
      t.column :granted,          :boolean
      t.column :notes,            :string
      t.timestamps 
    end
    
    execute 'ALTER TABLE log_records ADD CONSTRAINT fk_log_records_subject FOREIGN KEY ( subject_id ) REFERENCES subjects(id)'
    execute 'ALTER TABLE log_records ADD CONSTRAINT fk_log_records_scope FOREIGN KEY ( scope_id ) REFERENCES scopes(id)'
    execute 'ALTER TABLE log_records ADD CONSTRAINT fk_log_records_resource FOREIGN KEY ( resource_id ) REFERENCES resources(id)'
    
    
  end

  def self.down
    drop_table :log_records
  end
end
