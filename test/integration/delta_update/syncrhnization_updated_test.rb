require "test_helper"

module DeltaUpdate
  class SynchronizationUpdatedTest < ActionDispatch::IntegrationTest
    setup do
      @space = spaces(:synced)
      @entry = entries(:entry)

      stub_request(:get, "https://cdn.contentful.com/spaces/yadj1kx9rmg0/sync?access_token=#{@space.access_token}&sync_token=#{@space.next_sync_token}")
        .to_return(status: 200, body: {
          "nextSyncUrl" => "https://cdn.contentful.com/spaces/yadj1kx9rmg0/environments/master/sync?sync_token=12345",
          "items" => [
            {
              "sys" => {
                "id" => @entry.contentful_id,
                "type" => "Entry",
                "createdAt" => "2021-01-01T00:00:00.000Z",
                "updatedAt" => "2021-01-01T00:00:00.000Z",
                "revision" => 99,
                "publishedVersion" => 1,
                "fields" => {},
                "environment" => {
                  "sys" => {
                    "id" => @entry.environment.contentful_id,
                    "type" => "Environment"
                  }
                }
              }
            }
          ]
        }.to_json)
    end

    test "when pulling a delta update for a space, it should reflect the changes in the entries" do
      assert_changes "@entry.reload.revision", from: 2, to: 99 do
        SyncJob.perform_now(@space)
      end
    end
  end
end
