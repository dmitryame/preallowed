require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  context "A Role instance" do    
    setup do
      @role = Factory(:role)
    end
    should_belong_to :client
  end    
end
