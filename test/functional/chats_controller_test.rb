require 'test_helper'

class ChatsControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get check_user" do
    get :check_user
    assert_response :success
  end

  test "should get chatroom" do
    get :chatroom
    assert_response :success
  end

  test "should get update_chatroom" do
    get :update_chatroom
    assert_response :success
  end

  test "should get post_message" do
    get :post_message
    assert_response :success
  end

end
