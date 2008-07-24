class AddCleantogetherData < ActiveRecord::Migration
  def self.up
    # Client.create(:id => 2, :name => "cleantogether").save!
    # 
    # Scope.create(:id => 2, :name => "cleantogether_dev", :client_id => 2).save!
    # 
    # Role.create(:id => 2, :name => "user", :client_id => 2).save!
    # Role.create(:id => 3, :name => "team captain", :client_id => 2).save!
    # Role.create(:id => 4, :name => "admin", :client_id => 2).save!
    # 
    # Role.create(:id => 5, :name => "cleantogether_rest", :client_id => 1).save!
    # 
    # Subject.create(:id =>2, :name => "cleantogether_rest", :client_id => 1).save!
    # 
    # adminsPasswordPrincipal = 
    #      Principal.create :id => 3,
    #      :value => "35263a0f3aa0ea37b57027d3c9635725746644e3", 
    #      :principal_type_id      => 1, 
    #      :subject_id             => 2
    #  adminsPasswordPrincipal.save!
    #  adminsSaltPrincipal     = 
    #      Principal.create :id => 4,
    #      :value => "291247300.585749468074609", 
    #      :principal_type_id      => 2, 
    #      :subject_id             => 2
    #  adminsSaltPrincipal.save!
    # 
    #  Resource.create(:id => 2, :name => "^/clients/2/.*$|^/clients/2$", :resource_type_id => 1, :scope_id => 1).save!
    #  Resource.create(:id => 3, :name => "^/.*$", :resource_type_id => 1, :scope_id => 2).save!
    # 
    #  Resource.find(2).roles << Role.find(5)         
    #  Subject.find(2).roles << Role.find(5)
    # 
    #  Resource.find(3).roles << Role.find(2)         
    #  Resource.find(3).roles << Role.find(3)         
    #  Resource.find(3).roles << Role.find(4)         
  end

  def self.down
    # 
    # Resource.find(3).roles.delete(Role.find(2))
    # Resource.find(3).roles.delete(Role.find(3))
    # Resource.find(3).roles.delete(Role.find(4))
    # 
    # Subject.find(2).roles.delete(Role.find(5))
    # Resource.find(2).roles.delete(Role.find(5))
    #  
    # Resource.delete 2
    # Resource.delete 3
    # 
    # Principal.delete 4
    # Principal.delete 3
    # 
    # Subject.delete 2
    #  
    #  
    # Role.delete 2
    # Role.delete 3
    # Role.delete 4
    # Role.delete 5
    # 
    # Scope.delete 2
    # 
    # Client.delete 2
  end
end
