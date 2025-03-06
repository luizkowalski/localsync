class Link < ApplicationRecord
  belongs_to :entry
  belongs_to :linked_entry, class_name: "Entry"

  validates :entry_id, uniqueness: { scope: :linked_entry_id }
end
