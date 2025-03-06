class FullSyncJob < ApplicationJob
  queue_as :default

  def perform(space)
    space.entries.destroy_all
    space.full_sync
  end
end
