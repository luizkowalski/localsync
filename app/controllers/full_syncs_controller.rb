class FullSyncsController < ApplicationController
  before_action :set_space

  def create
    FullSyncJob.perform_later(@space)

    head :accepted
  end

  private

  def set_space
    @space = Space.find_by(contentful_id: params[:space_id])
  end
end
