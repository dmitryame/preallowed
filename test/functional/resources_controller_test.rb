require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase

  def setup
    #authenticate
    create_and_authenticate_preallowed_subject
     
    @controller = ResourcesController.new
  end

  should_be_restful do |resource| 
    resource.parent     = [ :client ]        
    resource.create.params = { :name => "random resource"}
    resource.update.params = { :name => "Changed"}
  end        


  context "on add role to resource" do
    setup do 
      resource = Factory(:resource, :client => @client)
      put :add_role, :id => resource.id, :role_id => @role.id, :client_id => @role.client.id
    end
    should_respond_with :ok
    should_not_set_the_flash      
    
  end

  context "on remove role from resource" do
    setup do 
      put :remove_role, :id => @resource.id, :role_id => @role.id, :client_id => @role.client.id 
    end
    should_respond_with :ok
    should_not_set_the_flash  
  end



end
