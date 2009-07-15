require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  context "A Subject instance" do    
    setup do
      @subject = Factory(:subject)
    end
    subject { @subject }
    
    should_belong_to :client
        
    should_have_db_index :client_id
    should_have_db_index [:client_id, :name]
    should_have_db_index [:client_id, :email]
    
    should_have_many :subjects_associations
    should_have_many :roles, :through => :subjects_associations
    
    should_have_many :profiles
    should_have_many :managed_clients, :through => :profiles
    
    should_ensure_length_in_range :email, (3..30) 
    should_ensure_length_in_range :name, (3..30) 
    should_ensure_length_in_range :password, (3..300) 
    should_ensure_length_in_range :salt, (3..100) 
    # should_validate_confirmation_of :password #such a method does not exist

    
    should_validate_presence_of :name, :client_id
    
    should_validate_uniqueness_of :name, :scoped_to => :client_id
    # should_require_unique_attributes :email, :scoped_to => :client_id
    
  end    
end
