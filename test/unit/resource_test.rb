require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
  context "A Resource instance" do    
    setup do
      @resource = Factory(:resource)
    end
    should_belong_to :client
  end    
end
