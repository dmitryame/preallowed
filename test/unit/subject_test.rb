require File.dirname(__FILE__) + '/../test_helper'

class SubjectTest < Test::Unit::TestCase
  context "A subject test" do    
    setup do
      @client = Factory(:preallowed_client)
      @subject = Factory(:subject, :name  => "RootLocusInc", :client => @client)

      @preallowed_client = Client.find 1
      @preallowed_subject = Factory.build(:subject, :name  => "RootLocusInc", :client => @preallowed_client, :email => "qwe@qwe.com")
    end

    # should "return its name" do
    #   assert_equal 'RootLocusInc', @subject.name
    # end
    
    should_belong_to :client
    should_have_and_belong_to_many :roles
    should_have_many :principals
    
    # should_allow_values_for :email, "qwe@qwe.com"
    
  end    

end
