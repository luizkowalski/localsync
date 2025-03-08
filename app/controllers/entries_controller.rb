class EntriesController < ApplicationController
  before_action :set_space

  def index
    @entries = @space.entries.includes(:space, :environment).order(created_at: :desc)
    @assets  = @space.assets.includes(:space, :environment).order(created_at: :desc)

    render json: EntrySerializer.new(@entries, @assets).to_json
  end

  private

  def set_space
    @space = Space.find_by(contentful_id: params[:space_id])
  end
end
