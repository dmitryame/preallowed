class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :salt
      t.integer :client_id
      
      t.timestamps
    end
    add_index :subjects, :client_id
    add_index :subjects, [:client_id, :email], :unique => true
    add_index :subjects, [:client_id, :name], :unique => true
  end

  def self.down
    remove_index :subjects, :client_id
    remove_index :subjects, [:client_id, :email]
    remove_index :subjects, [:client_id, :name]
    
    drop_table :subjects
  end
end
