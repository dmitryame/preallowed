require 'test_helper'

class SubjectsControllerTest < ActionController::TestCase
  # def test_should_get_index
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:subjects)
  # end
  # 
  # def test_should_get_new
  #   get :new
  #   assert_response :success
  # end
  # 
  # def test_should_create_subject
  #   assert_difference('Subject.count') do
  #     post :create, :subject => { }
  #   end
  # 
  #   assert_redirected_to subject_path(assigns(:subject))
  # end
  # 
  # def test_should_show_subject
  #   get :show, :id => subjects(:one).id
  #   assert_response :success
  # end
  # 
  # def test_should_get_edit
  #   get :edit, :id => subjects(:one).id
  #   assert_response :success
  # end
  # 
  # def test_should_update_subject
  #   put :update, :id => subjects(:one).id, :subject => { }
  #   assert_redirected_to subject_path(assigns(:subject))
  # end
  # 
  # def test_should_destroy_subject
  #   assert_difference('Subject.count', -1) do
  #     delete :destroy, :id => subjects(:one).id
  #   end
  # 
  #   assert_redirected_to subjects_path
  # end
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
