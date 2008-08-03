require File.dirname(__FILE__) + '/../test_helper'

class RoleTest < Test::Unit::TestCase
  context "A role instance" do    
    setup do
      @role = Factory(:role)
    end
  end

  should_belong_to :client
  should_have_and_belong_to_many :resources
  should_have_and_belong_to_many :subjects
  
  should_require_attributes :name
  
end
