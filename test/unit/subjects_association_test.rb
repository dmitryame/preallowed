require 'test_helper'

class SubjectsAssociationTest < ActiveSupport::TestCase
  context "A Subjects Association instance" do    
     setup do
       @subjects_association = Factory(:subjects_association)
     end
     
     should_belong_to :subject  
     should_belong_to :role
     should_have_indices :subject_id, :role_id
   end
 end
