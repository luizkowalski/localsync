module Syncable
  extend ActiveSupport::Concern

  def sync(full: false)
    items, next_sync_token = Contentful::API.new(self).sync(full:)

    items.each { |item| Contentful::EntryOrAsset.new(item, self).sync }

    update(last_synced_at: Time.current, next_sync_token: next_sync_token)
  end
end
