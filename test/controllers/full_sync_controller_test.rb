require "test_helper"

class FullSyncControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get full_sync_create_url
    assert_response :success
  end
end
