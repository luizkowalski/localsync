class SyncJob < ApplicationJob
  queue_as :default

  def perform(space)
    space.sync
  end
end
