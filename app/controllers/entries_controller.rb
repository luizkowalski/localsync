class EntriesController < ApplicationController
  before_action :set_space

  def index
    @entries = @space.entries.includes(:space, :environment).order(created_at: :desc)

    @linked_entities = Entity.where(id: @space.links.pluck(:linked_entity_id, :entity_id).flatten.uniq).includes(:space, :environment)

    render json: EntrySerializer.new(@entries, @linked_entities).to_json
  end

  private

  def set_space
    @space = Space.find_by(contentful_id: params[:space_id])
  end
end
