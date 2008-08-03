require File.dirname(__FILE__) + '/../test_helper'

class ResourceTypeTest < Test::Unit::TestCase
  context "A resource_type instance" do    
    setup do
      @resource_type = Factory(:resource_type)
    end
  end

  should_have_many :resources
end
