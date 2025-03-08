module Contentful
  class Entity
    def initialize(data, space)
      @data = data
      @space = space
    end

    def sync
      case entry_type
      when "Entry"
        ::Entry.find_or_initialize_by(contentful_id:, space:, environment:).update!(upstream_data)
      when "Asset"
        ::Asset.find_or_initialize_by(contentful_id:, space:, environment:).update!(upstream_data)
      when /^deleted/i
        ::Entity.find_by(contentful_id: contentful_id, space:)&.destroy!
      end
    end

    private

    attr_reader :data, :space

    def contentful_id
      data["sys"]["id"]
    end

    def entry_type
      data["sys"]["type"]
    end

    def environment
      Environment.find_or_create_by!(contentful_id: data.dig("sys", "environment", "sys", "id"), space:)
    end

    def upstream_data
      {
        created_at: data["sys"]["createdAt"],
        updated_at: data["sys"]["updatedAt"],
        content_type_id: data.dig("sys", "contentType", "sys", "id"),
        published_version: data["sys"]["publishedVersion"],
        revision: data["sys"]["revision"],
        fields: data["fields"]
      }
    end
  end
end
