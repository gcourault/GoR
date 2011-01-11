require 'test_helper'

class MaestrolistasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:maestrolistas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create maestrolista" do
    assert_difference('Maestrolista.count') do
      post :create, :maestrolista => { }
    end

    assert_redirected_to maestrolista_path(assigns(:maestrolista))
  end

  test "should show maestrolista" do
    get :show, :id => maestrolistas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => maestrolistas(:one).to_param
    assert_response :success
  end

  test "should update maestrolista" do
    put :update, :id => maestrolistas(:one).to_param, :maestrolista => { }
    assert_redirected_to maestrolista_path(assigns(:maestrolista))
  end

  test "should destroy maestrolista" do
    assert_difference('Maestrolista.count', -1) do
      delete :destroy, :id => maestrolistas(:one).to_param
    end

    assert_redirected_to maestrolistas_path
  end
end
