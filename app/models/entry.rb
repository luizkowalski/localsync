class Entry < ApplicationRecord
  belongs_to :space
  belongs_to :environment

  enum :entry_type, [ "asset", "entry" ].index_by(&:itself)

  validates :content_type_id, presence: true, if: -> { entry? }

  has_many :links, foreign_key: :entry_id, dependent: :destroy
  has_many :linked_entries, through: :links, source: :linked_entry
end
