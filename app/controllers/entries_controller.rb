class EntriesController < ApplicationController
  before_action :set_space

  def index
    @pagy, @entries = pagy(
      Entry.entry.where(space: @space).includes(:space, :environment).order(created_at: :desc),
      page: page_param,
      limit: limit_param
    )

    # For the assets, get only asset-type entries that are linked to the paginated entries we will display
    @assets = Entry.asset.where(id: Link.where(entry_id: @entries.load.ids).pluck(:linked_entry_id)).includes(:space, :environment)

    render json: EntrySerializer.new(@entries, @assets, @pagy).to_json
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
