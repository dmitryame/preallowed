require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
  context "A Resource instance" do    
    setup do
      @resource = Factory(:resource)
    end
    should_belong_to :client
    
    should_ensure_length_in_range :name, (3..2048) 
    
    
  end    
end
