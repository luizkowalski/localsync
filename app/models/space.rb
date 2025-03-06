class Space < ApplicationRecord
  belongs_to :environment, optional: true
end
