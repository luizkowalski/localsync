class Entity < ApplicationRecord
  belongs_to :space
  belongs_to :environment

  has_many :links, foreign_key: :entity_id, dependent: :destroy
  has_many :linked_entities, through: :links, source: :linked_entity, dependent: :destroy

  after_commit :link_entries

  private

  def link_entries
    Contentful::Link.new(self).create
  end
end
