class SyncJob < ApplicationJob
  queue_as :default

  def perform(space)
  end
end
