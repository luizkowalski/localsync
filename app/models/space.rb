class Space < ApplicationRecord
  include Syncable

  has_many :environments, dependent: :destroy
  has_many :entities, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :assets, dependent: :destroy

  has_many :links, through: :entities
end
