class CreateLogRecords < ActiveRecord::Migration
  def self.up
    create_table :log_records do |t|
      t.string :req_body, :req_headers, :req_method, :req_path, :resp_status, :resp_headers, :limit => 2048
      t.timestamps 
    end        
  end

  def self.down
    drop_table :log_records
  end
end
