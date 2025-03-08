module Contentful
  class Link
    def initialize(entity)
      @entity = entity
    end

    # We start by deleting all the links for the entry, then we create the new ones.
    # This is because we don't want to have orphaned links in the database.
    def create
      ::Link.where(entity:).delete_all

      links.each do |link|
        linked_entity = ::Entity.find_or_initialize_by(
          contentful_id: link["sys"]["id"],
          type: link["sys"]["linkType"],
          space: entity.space,
          environment: entity.environment
        )

        ::Link.create!(entity:, linked_entity:)
      end
    end

    private

    attr_reader :entity

    def links
      return [] unless entity.fields

      extract_links(entity.fields)
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
  end
end
