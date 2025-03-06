class Entry < ApplicationRecord
  belongs_to :space

  enum :entry_type, [ "asset", "entry" ].index_by(&:itself)

  validates :content_type_id, presence: true, if: -> { entry? }
end
