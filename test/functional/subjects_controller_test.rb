require File.dirname(__FILE__) + '/../test_helper'

class SubjectsControllerTest < ActionController::TestCase

  def setup
    @subject = Factory(:subject)
    
    @controller = SubjectsController.new
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
    resource.actions    = [
      # :index, #TODO: add index to controller and to test
      :show, 
      :new, 
      :edit, 
      :update, 
      :create, 
      :destroy
      ]
    
    resource.parent     = [ :client ]    
    resource.create.params = { :name => "random subject", :email => "qwe@qwe.com" }
    resource.update.params = { :name => "Changed", :email => "qwe@qwe.com" }
  end        
end
