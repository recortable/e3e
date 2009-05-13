require 'test_helper'

class AdminSessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    AdminSession.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    AdminSession.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
  
  def test_destroy
    admin_session = AdminSession.first
    delete :destroy, :id => admin_session
    assert_redirected_to root_url
    assert !AdminSession.exists?(admin_session.id)
  end
end
