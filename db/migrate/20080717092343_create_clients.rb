class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
        t.column :name,       :string
        t.timestamps 
    end
    #add default client   
    preallowed = Client.create :name => "rootlocus", :id => 1
    preallowed.save!
    
  end

  def self.down
    drop_table :clients
  end
end
