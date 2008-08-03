require File.dirname(__FILE__) + '/../test_helper'

class ResourceTest < Test::Unit::TestCase
  context "A resource instance" do    
    setup do
      @resource = Factory(:resource)
    end
  end

  should_belong_to :resource_type
  should_have_and_belong_to_many :roles
  should_belong_to :scope
  
  should_require_attributes :name
  
end
