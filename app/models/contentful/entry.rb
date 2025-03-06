module Contentful
  class Entry
    def initialize(data, space)
      @data = data
      @space = space
    end

    def sync
      case entry_type
      when "entry", "asset"
        ::Entry.find_or_initialize_by(contentful_id: contentful_id, space:).update!(
          upstream_data
        )
      when /^Deleted/
        ::Entry.find_by(contentful_id: contentful_id, space:)&.destroy
      end
    end

    private

    attr_reader :data, :space

    def contentful_id
      data["sys"]["id"]
    end

    def entry_type
      data["sys"]["type"].downcase
    end

    def links(hash: data["fields"])
      return [] unless hash

      extract_links(hash)
    end

    def extract_links(value)
      links = []

      case value
      when Hash
        links << value if value["sys"]

        value.each_value do |v|
          links.concat(extract_links(v))
        end
      when Array
        value.each do |item|
          links.concat(extract_links(item))
        end
      end

      links
    end

    def upstream_data
      {
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
