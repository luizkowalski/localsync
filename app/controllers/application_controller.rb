class ApplicationController < ActionController::API
  def set_space
    @space = Space.find_by(contentful_id: params[:space_id])
    head :not_found unless @space
  end
end
