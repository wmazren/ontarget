class GoalsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
  end
  
  def show
    @goal = Goal.find(params[:id])
  end
  
  def new
    @goal = Goal.new
  end

  def create
    @review = Review.find_by_user_id(current_user).id.to_i
    @goal = current_user.goals.build(params[:goal])
    @goal.review_id = @review
    @progress = @goal.build_progress(params[:progress])
    @progress.user_id = @goal.user_id
    if @goal.save
      flash[:notice] = "Goal created"
      redirect_to dashboards_path
    else
      render 'new'
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end
  
  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(params[:goal])
      flash[:notice] = "Successfully updated goal."
      redirect_to goals_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    flash[:notice] = "Successfully destroyed goal."
    redirect_to goals_url
  end
end
