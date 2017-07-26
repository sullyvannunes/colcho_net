class Rooms::ReviewsController < Rooms::BaseController
  before_action :require_authentication
  def create
    review = room.reviews.find_or_initialize_by(user_id: current_user.id)
    review.update_attributes!(params[:review])
    head :ok
  end

  def update
    create
  end
end
