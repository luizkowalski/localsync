class FullSyncJob < ApplicationJob
  queue_as :default

  def perform(space)
    Link.where(entry: space.entries).or(
      Link.where(linked_entry: space.entries)
    ).delete_all

    Entry.where(space:).delete_all

    space.sync(full: true)
  end
end
