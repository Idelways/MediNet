require 'test_helper'

class ProfilControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get import" do
    get :import
    assert_response :success
  end

end
