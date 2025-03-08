class EntrySerializer
  def initialize(entries, linked_entities)
    @entries = entries
    @linked_entities = linked_entities
  end

  def to_json
    {
      sys: {
        type: "Array"
      },
      total: @entries.size,
      items: @entries.map do |entry|
        {
          sys: {
            space: {
              sys: {
                id: entry.space.contentful_id,
                type: "Link",
                linkType: "Space"
              }
            },
            id: entry.contentful_id,
            type: entry.type,
            contentType: {
              sys: {
                id: entry.content_type_id,
                type: "Link",
                linkType: "ContentType"
              },
              publishedVersion: entry.published_version,
              revision: entry.revision,
              createdAt: entry.created_at,
              updatedAt: entry.updated_at
            },
            environment: {
              sys: {
                id: entry.environment.contentful_id,
                type: "Link",
                linkType: "Environment"
              }
            }
          },
          fields: entry.fields
        }
      end,
      includes: {
        Entries: IncludeSerializer.new(@linked_entities.select { |e| e.type == "Entry" }).to_json,
        Assets: IncludeSerializer.new(@linked_entities.select { |e| e.type == "Asset" }).to_json
      }.compact_blank
    }
  end
end
