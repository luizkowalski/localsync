class EntrySerializer
  def initialize(entries, pagy = nil)
    @entries = entries
    @pagy    = pagy
  end

  def to_json
    {
      sys: {
        type: "Array"
      },
      total: @pagy.count,
      skip: (@pagy.page - 1) * @pagy.limit,
      limit: @pagy.limit,
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
            type: entry.entry_type.titleize,
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
        Asset: IncludesSerializer.new(@entries.flat_map(&:linked_entries).select(&:asset?)).to_json,
        Entry: IncludesSerializer.new(@entries.flat_map(&:linked_entries).select(&:entry?)).to_json
      }
    }
  end
end
