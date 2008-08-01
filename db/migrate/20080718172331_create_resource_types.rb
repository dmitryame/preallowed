class CreateResourceTypes < ActiveRecord::Migration
  def self.up
    create_table :resource_types do |t|
      t.column :name,         :string
      t.timestamps 
    end
  end

  def self.down
    drop_table :resource_types
  end
end
