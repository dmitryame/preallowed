require File.dirname(__FILE__) + '/../test_helper'

class ResourceTypeTest < Test::Unit::TestCase
  context "A resource_type instance" do    
    setup do
      @resource_type = Factory(:resource_type)
    end

    should_require_attributes :name
    should_require_unique_attributes :name

    should_have_many :resources
  end

end
