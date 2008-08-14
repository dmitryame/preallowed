require 'test_helper'

class RolesControllerTest < ActionController::TestCase

  def setup
    #authenticate
    create_and_authenticate_preallowed_subject

    @controller = RolesController.new
  end

  should_be_restful do |resource| 
    resource.parent     = [ :client ]        
    resource.create.params = { :name => "random role"}
    resource.update.params = { :name => "Changed"}
  end        


  context "on add subject to role" do
    setup do 
      put :add_subject, :id => @role.id, :subject_id => @subject.id, :client_id => @subject.client.id
    end
    should_respond_with :ok
    should_not_set_the_flash      
    
  end

  context "on remove subject from role" do
    setup do 
      @subject.roles << @role
      put :remove_subject, :id => @role.id, :subject_id => @subject.id, :client_id => @subject.client.id # this should fail if the subject was not added to role first
    end
    should_respond_with :ok
    should_not_set_the_flash  
  end

  context "on add resource to role" do
    setup do 
      put :add_resource, :id => @role.id, :resource_id => @resource.id, :client_id => @resource.client.id 
    end
    should_respond_with :ok
    should_not_set_the_flash  
  end

  context "on remove resource from role" do
    setup do 
      @resource.roles << @role
      put :remove_resource, :id => @role.id, :resource_id => @resource.id, :client_id => @resource.client.id # this should fail if the resource was not added to role first
    end
    should_respond_with :ok
    should_not_set_the_flash  
  end




end
