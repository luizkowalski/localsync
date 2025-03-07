class EntrySerializer
  def initialize(entries, assets)
    @entries = entries
    @assets  = assets
  end

  def to_json
    {
      sys: {
        type: "Array"
      },
      total: @entries.count,
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
            }
          },
          fields: entry.fields
        }
      end,
      includes: {
        Asset: AssetSerializer.new(@assets).to_json
      }
    }
  end
end
