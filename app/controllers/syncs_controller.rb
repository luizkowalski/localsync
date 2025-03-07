class SyncsController < ApplicationController
  before_action :set_space

  def create
    SyncJob.perform_later(@space)

    head :accepted
  end
end
