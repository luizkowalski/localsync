class AssetSerializer
  def initialize(assets)
    @assets = assets
  end

  def to_json
    @assets.map do |asset|
      {
        sys: {
          space: {
            sys: {
              id: asset.space.contentful_id,
              type: "Link",
              linkType: "Space"
            }
          },
          id: asset.contentful_id,
          type: "Asset",
          createdAt: asset.created_at,
          updatedAt: asset.updated_at,
          revision: asset.revision,
          publishedVersion: asset.published_version,
          environment: {
            sys: {
              id: asset.environment.contentful_id,
              type: "Link",
              linkType: "Environment"
            }
          },
          fields: asset.fields
        }
      }
    end
  end
end
