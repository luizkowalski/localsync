class Space < ApplicationRecord
  include Syncable

  has_many :environments
  has_many :entries
end
