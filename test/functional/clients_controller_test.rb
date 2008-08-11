require File.dirname(__FILE__) + '/../test_helper'
require 'clients_controller'

# Re-raise errors caught by the controller.
class ClientsController; def rescue_action(e) raise e end; end

class ClientsControllerTest < Test::Unit::TestCase


  def setup
    @client = Client.find(1)
    @controller = ClientsController.new
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
    resource.create.params = { :name => "random client" }
    resource.update.params = { :name => "Changed" }
  end        

end
