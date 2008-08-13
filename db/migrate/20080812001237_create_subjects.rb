class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.string :name
      t.string :email
      t.string :password
      t.integer :client_id
      
      t.timestamps
    end
    add_index :subjects, :name
    add_index :subjects, :client_id
    add_index :subjects, [:client_id, :email]
  end

  def self.down
    remove_index :subjects, :name
    remove_index :subjects, :client_id
    remove_index :subjects, [:client_id, :email]
    
    drop_table :subjects
  end
end
