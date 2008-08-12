require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  context "A Role instance" do    
    setup do
      @role = Factory(:role)
    end
    should_belong_to :client
    
    should_have_many :subjects_associations
    should_have_many :subjects, :through => :subjects_associations

    should_have_many :resources_associations
    should_have_many :resources, :through => :resources_associations
    
    should_ensure_length_in_range :name, (3..30) 
    
  end    
end
