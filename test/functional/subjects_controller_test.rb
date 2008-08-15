require 'test_helper'

class SubjectsControllerTest < ActionController::TestCase

  def setup
    #authenticate
    create_and_authenticate_preallowed_subject

    @controller = SubjectsController.new
  end

  should_be_restful do |resource| 
    resource.parent     = [ :client ]        
    resource.create.params = { :name => "random subject", :email => "qwe@qwe.com", :password => "qweqwe", :password_confirmation => "qweqwe"}
    resource.update.params = { :name => "Changed", :email => "qwe@qwe.com", :password => "qweqwe", :password_confirmation => "qweqwe"}
  end        

  context "on check if subject has access to a particuar resource -- expecting false" do
    setup do 
      # @subject.roles << @role
      # @resource.roles << @role
      get :has_access, :id => @subject.id, :resource => "test resource", :client_id => @subject.client.id # this should fail if the subject was not added to role first
    end
    should_not_set_the_flash  
    should "return false" do
      assert_tag :tag => "a", :content => "0"
    end
  end

  context "on check if subject has access to a particuar resource -- expecting true" do
    setup do 
      @resource.name = "^/clients/" + @client.id.to_s + "($|.xml$|/.*$)"
      @resource.save
      get :has_access, :id => @subject.id, :resource => "/clients/" + @client.id.to_s + "/any_method.xml", :client_id => @client.id # this should fail if the subject was not added to role first
    end
    should_not_set_the_flash  
    should "return true" do
      assert_tag :tag => "a", :content => "1" #returns true, meaning the subject has acces to the resource
    end
  end

  context "on check if subject in role -- expecting true" do
    setup do
      get :is_subject_in_role, :id => @subject.id, :role_id => @role.id , :client_id => @subject.client.id # this should fail if the subject was not added to role first
    end
    should_not_set_the_flash  
    should "return true" do
      assert_tag :tag => "a", :content => "1"
    end
  end


  context "on check if subject in role -- expecting false" do
    setup do
      another_role = Factory(:role, :client => @client) 
      get :is_subject_in_role, :id => @subject.id, :role_id => another_role.id , :client_id => @subject.client.id # this should fail if the subject was not added to role first
    end
    should_not_set_the_flash  
    should "return false" do
      assert_tag :tag => "a", :content => "0"
    end
  end

end
