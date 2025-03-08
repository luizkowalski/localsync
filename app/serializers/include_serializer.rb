class IncludeSerializer
  def initialize(entities)
    @entities = entities
  end

  def to_json
    @entities.map do |entity|
      {
        sys: {
          space: {
            sys: {
              id: entity.space.contentful_id,
              type: "Link",
              linkType: "Space"
            }
          },
          id: entity.contentful_id,
          type: entity.type,
          createdAt: entity.created_at,
          updatedAt: entity.updated_at,
          revision: entity.revision,
          publishedVersion: entity.published_version,
          environment: {
            sys: {
              id: entity.environment.contentful_id,
              type: "Link",
              linkType: "Environment"
            }
          }
        }.tap do |sys|
          # Only add contentType for Entry types
          if entity.type == "Entry"
            sys[:contentType] = {
              sys: {
                id: entity.content_type_id,
                type: "Link",
                linkType: "ContentType"
              }
            }
          end
        end,
        fields: entity.fields
      }
    end
  end
end
