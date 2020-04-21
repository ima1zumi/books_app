require 'test_helper'

class UserFollowControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_follow_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_follow_destroy_url
    assert_response :success
  end

end
