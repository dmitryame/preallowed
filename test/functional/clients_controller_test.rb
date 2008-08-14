require 'test_helper'

class ClientsControllerTest < ActionController::TestCase

  def setup
    @controller = ClientsController.new
    #authenticate
    create_and_authenticate_preallowed_subject
  end
 
  should_be_restful do |resource| 
    resource.create.params = { :name => "random client" }
    resource.update.params = { :name => "Changed" }
  end        

end
