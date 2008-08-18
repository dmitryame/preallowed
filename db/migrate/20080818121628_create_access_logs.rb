class CreateAccessLogs < ActiveRecord::Migration
  def self.up
    create_table :access_logs do |t|
      t.references :client
      t.string :request_body, :limit => 2048
      t.string :request_headers, :limit => 2048
      t.string :request_method
      t.string :request_path, :limit => 2048
      t.string :response_body, :limit => 10000
      t.string :response_headers, :limit => 2048
      t.string :response_status

      t.timestamps
    end
    add_index :access_logs, :client_id
  end

  def self.down
    remove_index :access_logs, :client_id

    drop_table :access_logs
  end
end
