require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase

  def setup
    @resource = Factory(:resource)
    @controller = ResourcesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  should_be_restful do |resource| 
    resource.parent     = [ :client ]        
    resource.create.params = { :name => "random resource"}
    resource.update.params = { :name => "Changed"}
  end        


end
