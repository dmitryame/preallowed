require 'test_helper'

class ResourcesAssociationTest < ActiveSupport::TestCase
  context "A Resources Associations instance" do    
     setup do
       @resources_association = Factory(:resources_association)
     end
     
     should_belong_to :resource
     should_belong_to :role
     should_have_db_indices :resource_id, :role_id, [:role_id, :resource_id]
     should_validate_presence_of :resource_id, :role_id
   end
end
