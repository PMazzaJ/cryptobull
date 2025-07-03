require "test_helper"

class UserProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_profile_index_url
    assert_response :success
  end
end
