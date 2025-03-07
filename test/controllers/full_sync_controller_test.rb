require "test_helper"

class FullSyncControllerTest < ActionDispatch::IntegrationTest
  test "should enqueue a full sync" do
    assert_enqueued_jobs 1, only: FullSyncJob do
      post space_full_sync_url(spaces(:synced).contentful_id)
    end

  assert_response :accepted
  end

  test "should not enqueue a full sync if the space doesn't exist" do
    assert_no_enqueued_jobs only: FullSyncJob do
      post space_full_sync_url("m1551ng")
    end

    assert_response :not_found
  end
end
