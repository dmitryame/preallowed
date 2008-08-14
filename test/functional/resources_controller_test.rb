require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase

  def setup
    #authenticate
    create_and_authenticate_preallowed_subject
     
    @controller = ResourcesController.new
  end

  should_be_restful do |resource| 
    resource.parent     = [ :client ]        
    resource.create.params = { :name => "random resource"}
    resource.update.params = { :name => "Changed"}
  end        


end
