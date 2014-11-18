require 'test_helper'

class SystemusersControllerTest < ActionController::TestCase
  setup do
    @systemuser = systemusers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:systemusers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create systemuser" do
    assert_difference('Systemuser.count') do
      post :create, systemuser: @systemuser.attributes
    end

    assert_redirected_to systemuser_path(assigns(:systemuser))
  end

  test "should show systemuser" do
    get :show, id: @systemuser.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @systemuser.to_param
    assert_response :success
  end

  test "should update systemuser" do
    put :update, id: @systemuser.to_param, systemuser: @systemuser.attributes
    assert_redirected_to systemuser_path(assigns(:systemuser))
  end

  test "should destroy systemuser" do
    assert_difference('Systemuser.count', -1) do
      delete :destroy, id: @systemuser.to_param
    end

    assert_redirected_to systemusers_path
  end
end
