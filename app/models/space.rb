class Space < ApplicationRecord
  include Syncable

  belongs_to :environment, optional: true

  has_many :entries

  URL = "https://cdn.contentful.com/spaces"
  def sync_url(initial: false)
    "#{URL}/#{contentful_id}/sync?access_token=#{access_token}&initial=#{initial}"
  end
end
