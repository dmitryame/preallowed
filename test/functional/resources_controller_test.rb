require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase
  # def test_should_get_index
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:resources)
  # end
  # 
  # def test_should_get_new
  #   get :new
  #   assert_response :success
  # end
  # 
  # def test_should_create_resource
  #   assert_difference('Resource.count') do
  #     post :create, :resource => { }
  #   end
  # 
  #   assert_redirected_to resource_path(assigns(:resource))
  # end
  # 
  # def test_should_show_resource
  #   get :show, :id => resources(:one).id
  #   assert_response :success
  # end
  # 
  # def test_should_get_edit
  #   get :edit, :id => resources(:one).id
  #   assert_response :success
  # end
  # 
  # def test_should_update_resource
  #   put :update, :id => resources(:one).id, :resource => { }
  #   assert_redirected_to resource_path(assigns(:resource))
  # end
  # 
  # def test_should_destroy_resource
  #   assert_difference('Resource.count', -1) do
  #     delete :destroy, :id => resources(:one).id
  #   end
  # 
  #   assert_redirected_to resources_path
  # end
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
