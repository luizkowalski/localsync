module Syncable
  extend ActiveSupport::Concern

  def full_sync
    url = sync_url(initial: true)
    next_sync_token = nil
    items = []

    while url
      begin
        response = Faraday.get(url)

        if response.success?
          data = JSON.parse(response.body)

          if data["items"].is_a?(Array)
            items.concat(data["items"])
          end

          next_sync_token = URI.parse(data["nextSyncUrl"]).query.sub("sync_token=", "")
          url = data["nextPageUrl"] ? "#{data["nextPageUrl"]}&access_token=#{access_token}" : nil
        else
          Rails.logger.error("Failed to fetch data: #{response.status} - #{response.body}")
          raise "Failed to fetch data: #{response.status} - #{response.body}"
        end
      end
    end

    items.each { |item| Contentful::Entry.new(item, self).sync }

    update(last_synced_at: Time.current, next_sync_token: next_sync_token)
  end

  def sync
  end
end
