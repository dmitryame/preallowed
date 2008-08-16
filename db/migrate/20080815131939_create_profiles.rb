class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.references :client, :null => false
      t.references :subject, :null => false

      t.timestamps
    end
    add_index :profiles, [:client_id, :subject_id], :unique => true
    add_index :profiles, :client_id
    add_index :profiles, :subject_id
  end

  def self.down
    remove_index :profiles, [:client_id, :subject_id]
    remove_index :profiles, :client_id
    remove_index :profiles, :subject_id
    
    drop_table :profiles
  end
end
