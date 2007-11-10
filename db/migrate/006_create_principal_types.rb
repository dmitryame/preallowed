class CreatePrincipalTypes < ActiveRecord::Migration
  def self.up
    create_table :principal_types do |t|
      t.column :name,         :string
      t.column :created_at,   :datetime,  :null => false
      t.column :updated_at,   :datetime,  :null => false      
    end
    #add default principal types here   
    plainPassword = PrincipalType.create :name => "password"
    plainPassword.save!
    
  end

  def self.down
    drop_table :principal_types
  end
end
