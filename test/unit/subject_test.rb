require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  context "A Subject instance" do    
    setup do
      @subject = Factory(:subject)
    end
    should_belong_to :client
    
    should_have_index :name
    should_have_index :client_id
    should_have_index [:client_id, :email]
    
    should_have_many :subjects_associations
    should_have_many :roles, :through => :subjects_associations
    
    should_ensure_length_in_range :email, (3..30) 
    should_ensure_length_in_range :name, (3..30) 
    should_ensure_length_in_range :password, (3..300) 
    
    should_require_unique_attributes :name, :scoped_to => :client_id
    should_require_unique_attributes :email, :scoped_to => :client_id
    
  end    
end
