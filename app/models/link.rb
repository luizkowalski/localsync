class Link < ApplicationRecord
  belongs_to :entity
  belongs_to :linked_entity, class_name: "Entity"

  validates :entity_id, uniqueness: { scope: :linked_entity_id }
end
