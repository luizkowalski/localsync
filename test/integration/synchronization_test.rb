require "test_helper"

class SynchronizationTest < ActionDispatch::IntegrationTest
  test "when fully syncing a space, it should create the correct number of entries" do
    assert_changes "Entry.entry.count", from: 1, to: 13 do
      VCR.use_cassette("spaces/yadj1kx9rmg0/full_sync") do
        FullSyncJob.perform_now(spaces(:synced))
      end
    end
  end

  test "when fully syncing a space, it should create the correct number of assets" do
    assert_changes "Entry.asset.count", from: 1, to: 11 do
      VCR.use_cassette("spaces/yadj1kx9rmg0/full_sync") do
        FullSyncJob.perform_now(spaces(:synced))
      end
    end
  end

  test "when fully syncing a space, it should update the last_synced_at field" do
    assert_changes "spaces(:synced).last_synced_at" do
      VCR.use_cassette("spaces/yadj1kx9rmg0/full_sync") do
        FullSyncJob.perform_now(spaces(:synced))
      end
    end
  end

  test "when fully syncing a space, it should update the next_sync_token field" do
    assert_changes "spaces(:synced).next_sync_token" do
      VCR.use_cassette("spaces/yadj1kx9rmg0/full_sync") do
        FullSyncJob.perform_now(spaces(:synced))
      end
    end
  end
end
