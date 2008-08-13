require 'test_helper'

class RolesControllerTest < ActionController::TestCase
  # def test_should_get_index
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:roles)
  # end
  # 
  # def test_should_get_new
  #   get :new
  #   assert_response :success
  # end
  # 
  # def test_should_create_role
  #   assert_difference('Role.count') do
  #     post :create, :role => { }
  #   end
  # 
  #   assert_redirected_to role_path(assigns(:role))
  # end
  # 
  # def test_should_show_role
  #   get :show, :id => roles(:one).id
  #   assert_response :success
  # end
  # 
  # def test_should_get_edit
  #   get :edit, :id => roles(:one).id
  #   assert_response :success
  # end
  # 
  # def test_should_update_role
  #   put :update, :id => roles(:one).id, :role => { }
  #   assert_redirected_to role_path(assigns(:role))
  # end
  # 
  # def test_should_destroy_role
  #   assert_difference('Role.count', -1) do
  #     delete :destroy, :id => roles(:one).id
  #   end
  # 
  #   assert_redirected_to roles_path
  # end

  def setup
    @client = Factory(:client)
    @role = Factory(:role, :client => @client)    
    @subject = Factory(:subject, :client => @client)
    
    @controller = RolesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  should_be_restful do |resource| 
    resource.parent     = [ :client ]        
    resource.create.params = { :name => "random role"}
    resource.update.params = { :name => "Changed"}
  end        


  context "on add subject to role" do
     setup do 
       put :add_subject, :id => @role.id, :subject_id => @subject.id, :client_id => @subject.client.id 
     end
  
     should_respond_with :ok
     should_not_set_the_flash
  
   end


end
