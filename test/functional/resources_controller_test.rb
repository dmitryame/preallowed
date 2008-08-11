require File.dirname(__FILE__) + '/../test_helper'

class ResourcesControllerTest < ActionController::TestCase
  def setup
     @resource = Factory(:resource)
     @controller = ResourcesController.new
     @request    = ActionController::TestRequest.new
     @response   = ActionController::TestResponse.new
     #authenticate
     @request.env['HTTP_AUTHORIZATION'] = 
     ActionController::HttpAuthentication::Basic.encode_credentials(
     "admin", 
     "admin" 
     )     
   end
  
   should_be_restful do |resource| 
     resource.formats    = [:html]
     
     resource.parent     = [:client, :scope]
     resource.actions    = [
       # :index, #TODO: add index to controller and to test
       :show, 
       :new, 
       :edit, 
       :update, 
       :create, 
       :destroy
       ]
     
     resource.create.params = { :name => "random value", :resource_type_id => 1 }
     resource.update.params = { :name => "updated value", :resource_type_id => 1 }
     
   end        
end
