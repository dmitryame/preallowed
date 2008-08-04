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

  should_eventually "be restful" do # TODO: write should_be_restful test
    should_be_restful do |resource| # TODO: figure out how to test forms with fields_for nested form attributes
      resource.create.params = { :name => "random subject", :email => "qwe@qwe.com" }#, :subject => { :email =>"ddd", :password=>"qweqweqwe", :password_confirmation=>"qweqweqwe"} }
      resource.update.params = { :name => "Changed", :email => "qwe@qwe.com" }
      resource.parent     = [ :client ]    
    end        
  end
end
