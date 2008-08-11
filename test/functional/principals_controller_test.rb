require File.dirname(__FILE__) + '/../test_helper'

class PrincipalsControllerTest < ActionController::TestCase

  def setup
     @principal = Factory(:salt_principal)
     @controller = PrincipalsController.new
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
     # resource.formats    = [:html]
     resource.parent     = [:client, :subject]
     resource.actions    = [
       #:index, #TODO: add index to controller and to test
       :show, 
       :new, 
       :edit, 
       :update, 
       :create, 
       :destroy
       ]
     
     resource.create.params = { :value => "random value", :principal_type_id => 1 }
     resource.update.params = { :value => "updated value", :principal_type_id => 1 }
     
   end        

end
