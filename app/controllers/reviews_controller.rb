class ReviewsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
  end
  
  def show
    @review = Review.find(params[:id])
  end
  
  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(params[:review])
      flash[:notice] = "Successfully updated review."
      redirect_to dashboards_path
    else
      render :action => 'edit'
    end
  end
end
