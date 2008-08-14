require 'test_helper'

class ClientsControllerTest < ActionController::TestCase

  def setup
    @client = Factory(:client)
    @controller = ClientsController.new
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
    resource.create.params = { :name => "random client" }
    resource.update.params = { :name => "Changed" }
  end        

end
