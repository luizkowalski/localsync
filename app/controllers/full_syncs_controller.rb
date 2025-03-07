class FullSyncsController < ApplicationController
  before_action :set_space

  def create
    FullSyncJob.perform_later(@space)

    head :accepted
  end
end
