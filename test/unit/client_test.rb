require File.dirname(__FILE__) + '/../test_helper'

class ClientTest < Test::Unit::TestCase
  context "A Client instance" do    
    setup do
      @client = Factory(:client)
    end
    
    should_require_attributes :name
    should_require_unique_attributes :name

    should_have_many :scopes
    should_have_many :roles
    should_have_many :subjects
  end    
end
