class EntriesController < ApplicationController
  before_action :set_space

  def index
    @pagy, @entries = pagy(
      Entry.entry.where(space: @space).preload(:space, :environment, linked_entries: [ :space, :environment ]).order(created_at: :desc),
      page: page_param,
      limit: limit_param
    )

    render json: EntrySerializer.new(@entries, @pagy).to_json
  end

  private

  def skip_param
    params[:skip].to_i || 0
  end

  def page_param
    (skip_param / Pagy::DEFAULT[:limit]) + 1
  end

  def limit_param
    params[:limit] || Pagy::DEFAULT[:limit]
  end

  def set_space
    @space = Space.find_by(contentful_id: params[:space_id])
  end
end
