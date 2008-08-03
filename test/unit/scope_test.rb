require File.dirname(__FILE__) + '/../test_helper'

class ScopeTest < Test::Unit::TestCase
  context "A scope instance" do    
    setup do
      @scope = Factory(:scope)
    end
    
    should_belong_to :client
    should_have_many :resources  
    
    should_require_attributes :name    
  end
end
