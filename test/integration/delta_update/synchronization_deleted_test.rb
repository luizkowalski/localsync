require "test_helper"

module DeltaUpdate
  class SynchronizationDeletedTest < ActionDispatch::IntegrationTest
    setup do
      @space = spaces(:synced)
      @entity = entities(:entry)

    stub_request(:get, "https://cdn.contentful.com/spaces/yadj1kx9rmg0/sync?access_token=#{@space.access_token}&sync_token=#{@space.next_sync_token}")
      .to_return(status: 200, body: {
          "nextSyncUrl" => "https://cdn.contentful.com/spaces/yadj1kx9rmg0/environments/master/sync?sync_token=12345",
          "items" => [
            {
              "sys" => {
                "id" => @entity.contentful_id,
                "type" => "DeletedEntry",
                "deletedAt" => "2021-01-01T00:00:00.000Z"
              }
            }
          ]
      }.to_json)
  end

  test "when pulling a delta update for a space, it should reflect the changes in the entries" do
    assert_changes "Entry.count", from: 1, to: 0 do
      SyncJob.perform_now(@space)
    end
  end

  test "when pulling a delta update for a space, it should reflect the changes in the linked entries" do
    assert_changes "Link.count", from: 1, to: 0 do
      SyncJob.perform_now(@space)
    end
  end

  test "when pulling a delta update for a space, the linked asset not be deleted" do
    assert_no_changes "Asset.count" do
      SyncJob.perform_now(@space)
    end
  end
  end
end
