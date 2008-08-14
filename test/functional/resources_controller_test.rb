require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase

  def setup
    @resource = Factory(:resource)
    @controller = ResourcesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    #authenticate
    @subject = Factory(:subject, :name => "admin", :password => "admin", :client => @resource.client)
    @request.env['HTTP_AUTHORIZATION'] = 
    ActionController::HttpAuthentication::Basic.encode_credentials(
    "admin", 
    "admin" 
    )    
  end

  should_be_restful do |resource| 
    resource.parent     = [ :client ]        
    resource.create.params = { :name => "random resource"}
    resource.update.params = { :name => "Changed"}
  end        


end
