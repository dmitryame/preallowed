class CreatePrincipalTypes < ActiveRecord::Migration
  def self.up
    create_table :principal_types do |t|
      t.column :name,         :string
      t.timestamps 
    end    
  end

  def self.down
    drop_table :principal_types
  end
end
