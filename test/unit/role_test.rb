require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  context "A Role instance" do    
    setup do
      @role = Factory(:role)
    end
    should_belong_to :client
    
    should_ensure_length_in_range :name, (3..30) 
    
  end    
end
