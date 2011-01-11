require 'test_helper'

class SucursalsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sucursals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sucursal" do
    assert_difference('Sucursal.count') do
      post :create, :sucursal => { }
    end

    assert_redirected_to sucursal_path(assigns(:sucursal))
  end

  test "should show sucursal" do
    get :show, :id => sucursals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sucursals(:one).to_param
    assert_response :success
  end

  test "should update sucursal" do
    put :update, :id => sucursals(:one).to_param, :sucursal => { }
    assert_redirected_to sucursal_path(assigns(:sucursal))
  end

  test "should destroy sucursal" do
    assert_difference('Sucursal.count', -1) do
      delete :destroy, :id => sucursals(:one).to_param
    end

    assert_redirected_to sucursals_path
  end
end
