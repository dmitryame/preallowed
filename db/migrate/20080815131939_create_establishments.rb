class CreateEstablishments < ActiveRecord::Migration
  def self.up
    create_table :establishments do |t|
      t.references :client, :null => false
      t.references :subject, :null => false

      t.timestamps
    end
    add_index :establishments, [:client_id, :subject_id], :unique => true
    add_index :establishments, :client_id
    add_index :establishments, :subject_id
  end

  def self.down
    remove_index :establishments, [:client_id, :subject_id]
    remove_index :establishments, :client_id
    remove_index :establishments, :subject_id
    
    drop_table :establishments
  end
end
