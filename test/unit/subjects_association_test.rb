require 'test_helper'

class SubjectsAssociationTest < ActiveSupport::TestCase
  context "A Subjects Association instance" do    
     setup do
       @subjects_association = Factory(:subjects_association)
     end
     subject { @subjects_association }
     
     should_belong_to :subject  
     should_belong_to :role
     should_have_db_indices :subject_id, :role_id, [:role_id, :subject_id]
     should_validate_presence_of :subject_id, :role_id
   end
 end
