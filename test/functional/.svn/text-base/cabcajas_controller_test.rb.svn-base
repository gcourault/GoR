require 'test_helper'

class CabcajasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cabcajas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cabcaja" do
    assert_difference('Cabcaja.count') do
      post :create, :cabcaja => { }
    end

    assert_redirected_to cabcaja_path(assigns(:cabcaja))
  end

  test "should show cabcaja" do
    get :show, :id => cabcajas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cabcajas(:one).to_param
    assert_response :success
  end

  test "should update cabcaja" do
    put :update, :id => cabcajas(:one).to_param, :cabcaja => { }
    assert_redirected_to cabcaja_path(assigns(:cabcaja))
  end

  test "should destroy cabcaja" do
    assert_difference('Cabcaja.count', -1) do
      delete :destroy, :id => cabcajas(:one).to_param
    end

    assert_redirected_to cabcajas_path
  end
end
