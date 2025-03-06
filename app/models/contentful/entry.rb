module Contentful
  class Entry
    def initialize(data, space)
      @data = data
      @space = space
    end

    def sync
      entry_type = data["sys"]["type"]

      case entry_type.downcase
      when "entry", "asset"
        ::Entry.new(as_local_data).save!
      when /^Deleted/
        ::Entry.find_by(contentful_id: data["sys"]["id"])&.destroy
      end
    end

    private

    attr_reader :data, :space

    def as_local_data
      {
        contentful_id: data["sys"]["id"],
        created_at: data["sys"]["createdAt"],
        entry_type: data["sys"]["type"].downcase,
        updated_at: data["sys"]["updatedAt"],
        published_version: data["sys"]["publishedVersion"],
        revision: data["sys"]["revision"],
        content_type_id: data.dig("sys", "contentType", "sys", "id"),
        space:
      }
    end
  end
end
