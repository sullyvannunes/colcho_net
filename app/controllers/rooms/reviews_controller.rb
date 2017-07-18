class Rooms::ReviewsController < Rooms::BaseController
  before_filter :require_authentication
  def create
    review = room.reviews.find_or_initialize_by_user_id(current_user.id)
    review.update_attributes!(params[:review])
    head :ok
  end

  def update
    create
  end
end
