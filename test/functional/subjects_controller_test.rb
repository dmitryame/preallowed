require 'test_helper'

class SubjectsControllerTest < ActionController::TestCase

  def setup
    @client = Factory(:client)
    @role = Factory(:role, :client => @client)    
    @subject = Factory(:subject, :client => @client)
    @resource = Factory(:resource, :client => @client)

    @controller = SubjectsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    #authenticate
    @subject = Factory(:subject, :name => "admin", :password => "admin", :client => @client)
    @request.env['HTTP_AUTHORIZATION'] = 
    ActionController::HttpAuthentication::Basic.encode_credentials(
    "admin", 
    "admin" 
    )        
  end

  should_be_restful do |resource| 
    resource.parent     = [ :client ]        
    resource.create.params = { :name => "random subject"}
    resource.update.params = { :name => "Changed"}
  end        

  context "on check if subject has access to a particuar resource -- expecting false" do
    setup do 
      @subject.roles << @role
      @resource.roles << @role
      get :has_access, :id => @subject.id, :resource => "test resource", :client_id => @subject.client.id # this should fail if the subject was not added to role first
    end
    should_not_set_the_flash  
    should "return false" do
      assert_tag :tag => "a", :content => "0"
    end
  end

  context "on check if subject has access to a particuar resource -- expecting true" do
    setup do 
      @subject.roles << @role
      @resource.roles << @role
      @resource.name = "^/clients/3($|.xml$|/.*$)"
      @resource.save
      get :has_access, :id => @subject.id, :resource => "/clients/3/any_method.xml", :client_id => @subject.client.id # this should fail if the subject was not added to role first
    end
    should_not_set_the_flash  
    should "return false" do
      assert_tag :tag => "a", :content => "1" #returns true, meaning the subject has acces to the resource
    end
  end

  context "on check if subject in role -- expecting false" do
    setup do 
      # @subject.roles << @role
      get :is_subject_in_role, :id => @subject.id, :role_id => @role.id , :client_id => @subject.client.id # this should fail if the subject was not added to role first
    end
    should_not_set_the_flash  
    should "return false" do
      assert_tag :tag => "a", :content => "0"
    end
  end

  context "on check if subject in role -- expecting true" do
    setup do 
      @subject.roles << @role
      get :is_subject_in_role, :id => @subject.id, :role_id => @role.id , :client_id => @subject.client.id # this should fail if the subject was not added to role first
    end
    should_not_set_the_flash  
    should "return false" do
      assert_tag :tag => "a", :content => "1"
    end
  end



  context "on check if subject belongs to a particular role" do
  end

end
