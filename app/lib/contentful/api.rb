module Contentful
  class API
    BASE_URL = "https://cdn.contentful.com/spaces"

    def initialize(space)
      @space = space
    end

    def sync(full: false)
      url = sync_url(full:)
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
            url = data["nextPageUrl"] ? "#{data["nextPageUrl"]}&access_token=#{space.access_token}" : nil
          else
            Rails.logger.error("Failed to fetch data: #{response.status} - #{response.body}")
            raise StandardError, "Failed to fetch data: #{response.status} - #{response.body}"
          end
        end
      end

      [ items, next_sync_token ]
    end

    private

    attr_reader :space

    def sync_url(full:)
      url = +"#{BASE_URL}/#{space.contentful_id}/sync?access_token=#{space.access_token}"
      full ? url += "&initial=true" : url += "&sync_token=#{space.next_sync_token}"

      url
    end
  end
end
