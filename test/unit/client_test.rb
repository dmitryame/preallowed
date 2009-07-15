require 'test_helper'

class ClientTest < Test::Unit::TestCase
  context "A Client instance" do    
    setup do
      @client = Factory.create(:client, :preallowed => true)
    end
    
    should_have_many :subjects
    should_have_many :roles
    should_have_many :resources

    should_have_many :profiles
    should_have_many :administrators, :through => :profiles
    
    should_validate_presence_of :name
    should_validate_uniqueness_of :name

    should_have_db_index :name
    should_have_db_index :preallowed
    
    # should_require_attributes :email, :password
    
    should "make sure there is only one record with preallowed = true" do # this is how preallowed client is identified
        @preallowed_client = Factory(:client, :preallowed => false)
        assert_save @preallowed_client
        # TODO: test that there could be only one client with preallowed = true 
        # @preallowed_client = Factory(:client, :preallowed => true)
        # assert_save @preallowed_client
    end
    
  end    
end
