require 'test_helper'

class SubjectsControllerTest < ActionController::TestCase

  def setup
    @subject = Factory(:subject)
    @controller = SubjectsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  should_be_restful do |resource| 
    resource.parent     = [ :client ]        
    resource.create.params = { :name => "random subject"}
    resource.update.params = { :name => "Changed"}
  end        

end
