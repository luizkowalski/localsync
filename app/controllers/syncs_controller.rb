class SyncsController < ApplicationController
  def create
    SyncJob.perform_later(Space.first)

    head :accepted
  end
end
