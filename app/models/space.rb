class Space < ApplicationRecord
  include Syncable

  has_many :environments

  has_many :entries

  URL = "https://cdn.contentful.com/spaces"
  def sync_url(initial: false)
    "#{URL}/#{contentful_id}/sync?access_token=#{access_token}&initial=#{initial}"
  end
end
