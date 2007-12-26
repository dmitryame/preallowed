class CreatePrincipalTypes < ActiveRecord::Migration
  def self.up
    create_table :principal_types do |t|
      t.column :name,         :string
      t.timestamps 
    end
    #add default principal types here   
    plainPassword = PrincipalType.create :name => "hashed_password"
    plainPassword.save!

    salt = PrincipalType.create :name => "salt"
    salt.save!
    
  end

  def self.down
    drop_table :principal_types
  end
end
