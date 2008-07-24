class CreateResourceTypes < ActiveRecord::Migration
  def self.up
    create_table :resource_types do |t|
      t.column :name,         :string
      t.timestamps 
    end
    
    # add default resource_types types here
    ResourceType.create(:name => "URL ResourceType").save!
    ResourceType.create(:name => "Printer ResourceType").save!    
  end

  def self.down
    drop_table :resource_types
  end
end
