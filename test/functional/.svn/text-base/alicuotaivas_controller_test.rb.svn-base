require 'test_helper'

class AlicuotaivasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alicuotaivas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alicuotaiva" do
    assert_difference('Alicuotaiva.count') do
      post :create, :alicuotaiva => { }
    end

    assert_redirected_to alicuotaiva_path(assigns(:alicuotaiva))
  end

  test "should show alicuotaiva" do
    get :show, :id => alicuotaivas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => alicuotaivas(:one).to_param
    assert_response :success
  end

  test "should update alicuotaiva" do
    put :update, :id => alicuotaivas(:one).to_param, :alicuotaiva => { }
    assert_redirected_to alicuotaiva_path(assigns(:alicuotaiva))
  end

  test "should destroy alicuotaiva" do
    assert_difference('Alicuotaiva.count', -1) do
      delete :destroy, :id => alicuotaivas(:one).to_param
    end

    assert_redirected_to alicuotaivas_path
  end
end
