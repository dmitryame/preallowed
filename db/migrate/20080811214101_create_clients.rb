class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name

      t.timestamps
    end
    add_index :clients, :name
  end

  def self.down
    remove_index :clients, :name
    drop_table :clients
  end
end
