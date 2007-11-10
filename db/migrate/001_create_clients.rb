class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
        t.column :name,       :string
        t.column :created_at, :datetime, :null => false
        t.column :updated_at, :datetime, :null => false
    end
  end

  def self.down
    drop_table :clients
  end
end
