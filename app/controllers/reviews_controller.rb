class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @user_id = current_user.id
    if @restaurant.reviews.any?
      @restaurant.reviews.each do |review|
        if review.user_id == @user_id
          flash[:notice] = "You cannot review this restaurant more than once"
        else
          review = @restaurant.reviews.create(review_params)
          review.user_id = @user_id
        end
      end
    else
      review = @restaurant.reviews.create(review_params)
      review.user_id = @user_id
    end
    p review
    redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
