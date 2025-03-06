class FullSyncsController < ApplicationController
  def create
    FullSyncJob.perform_later(Space.first)

    head :accepted
  end
end
