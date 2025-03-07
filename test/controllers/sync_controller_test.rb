require "test_helper"

class SyncControllerTest < ActionDispatch::IntegrationTest
  test "should enqueue a sync" do
    assert_enqueued_jobs 1, only: SyncJob do
      post space_sync_url(spaces(:synced).contentful_id)
    end

    assert_response :accepted
  end

  test "should not enqueue a sync if the space doesn't exist" do
    assert_no_enqueued_jobs only: SyncJob do
      post space_sync_url("m1551ng")
    end
  end
end
