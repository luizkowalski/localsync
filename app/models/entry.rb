class Entry < ApplicationRecord
  belongs_to :space
  belongs_to :environment

  enum :entry_type, [ "asset", "entry" ].index_by(&:itself)

  has_many :links, foreign_key: :entry_id, dependent: :destroy
  has_many :linked_entries, through: :links, source: :linked_entry, dependent: :destroy

  after_commit :link_entries

  private

  def link_entries
    Contentful::Link.new(self).create
  end
end
