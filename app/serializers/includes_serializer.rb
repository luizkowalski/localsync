class IncludesSerializer
  def initialize(linked_entries)
    @linked_entries = linked_entries
  end

  def to_json
    @linked_entries.map do |linked_entry|
      {
        sys: {
          space: {
            sys: {
              id: linked_entry.space.contentful_id,
              type: "Link",
              linkType: "Space"
            }
          },
          id: linked_entry.contentful_id,
          type: linked_entry.entry_type.titleize,
          createdAt: linked_entry.created_at,
          updatedAt: linked_entry.updated_at,
          revision: linked_entry.revision,
          publishedVersion: linked_entry.published_version,
          environment: {
            sys: {
              id: linked_entry.environment.contentful_id,
              type: "Link",
              linkType: "Environment"
            }
          },
          fields: linked_entry.fields
        }
      }
    end
  end
end
