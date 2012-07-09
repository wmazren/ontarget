class ProgressesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def edit
    @progress = Progress.find(params[:id])
  end
  
  def update
    @progress = Progress.find(params[:id])
    if @progress.update_attributes(params[:progress])
      flash[:notice] = "Successfully updated progress."
      redirect_to dashboards_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @progress = Progress.find(params[:id])
    @progress.destroy
    flash[:notice] = "Successfully destroyed progress."
    redirect_to goals_url
  end
end
