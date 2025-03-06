require "test_helper"

class SyncControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get sync_create_url
    assert_response :success
  end
end
