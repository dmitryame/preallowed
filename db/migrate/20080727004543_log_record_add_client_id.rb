class LogRecordAddClientId < ActiveRecord::Migration
  def self.up
    add_column :log_records, :client_id, :integer
    add_index :log_records, :client_id
  end

  def self.down
    remove_index :log_records, :client_id
    remove_column :log_records, :client_id
  end
end
