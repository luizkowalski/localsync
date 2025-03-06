class Entry < ApplicationRecord
  belongs_to :space

  enum :entry_type, [ "asset", "entry" ].index_by(&:itself)
end
