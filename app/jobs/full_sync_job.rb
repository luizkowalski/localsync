class FullSyncJob < ApplicationJob
  queue_as :default

  def perform(space)
    ActiveRecord::Base.transaction do
      Link.where(entity: space.entities).or(
        Link.where(linked_entity: space.entities)
      ).delete_all

      space.entities.delete_all

      space.sync(full: true)
    end
  end
end
