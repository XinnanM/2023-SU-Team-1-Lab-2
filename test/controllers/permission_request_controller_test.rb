require "test_helper"

class PermissionRequestControllerTest < ActionDispatch::IntegrationTest
  test "should get approve" do
    get permission_request_approve_url
    assert_response :success
  end

  test "should get deny" do
    get permission_request_deny_url
    assert_response :success
  end
end
