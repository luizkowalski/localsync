module Contentful
  class Link
    def initialize(entry)
      @entry = entry
    end

    # We start by deleting all the links for the entry, then we create the new ones.
    # This is because we don't want to have orphaned links in the database.
    def create
      ::Link.where(entry:).delete_all

      links.each do |link|
        linked_entry = ::Entry.find_or_initialize_by(
          contentful_id: link["sys"]["id"],
          entry_type: link["sys"]["linkType"].downcase,
          space: entry.space,
          environment: entry.environment
        )

        ::Link.create!(entry:, linked_entry:)
      end
    end

    private

    attr_reader :entry

    def links
      return [] unless entry.fields

      extract_links(entry.fields)
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
