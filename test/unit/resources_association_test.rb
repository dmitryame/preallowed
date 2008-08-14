require 'test_helper'

class ResourcesAssociationTest < ActiveSupport::TestCase
  context "A Resources Associations instance" do    
     setup do
       @resources_association = Factory(:resources_association)
     end
     
     should_belong_to :resource
     should_belong_to :role
     should_have_indices :resource_id, :role_id
     should_require_attributes :resource_id, :role_id
   end
end
