require 'test_helper'

class ClientsControllerTest < ActionController::TestCase

  def setup
    @client = Factory(:client)
    @controller = ClientsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  should_be_restful do |resource| 
    resource.create.params = { :name => "random client" }
    resource.update.params = { :name => "Changed" }
  end        

end
