class PeriodsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @periods = Period.where(:account_id => current_user.account_id)
  end
  
  def show
    @period = Period.find(params[:id])
  end
  
  def new
    @period = Period.new
  end

  def create
    @period = Period.new(params[:period])
    @period.account_id = current_user.account_id
    if @period.save
      flash[:notice] = "Period created"
      redirect_to dashboards_path
    else
      redirect_to periods_path, alert: 'Unable to create new Period. An *OPEN* Period still exist'
    end
  end

  def edit
    @period = Period.find(params[:id])
  end
  
  def update
    @period = Period.find(params[:id])
    if @period.update_attributes(params[:period])
      flash[:notice] = "Successfully updated period."
      redirect_to periods_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @period = Period.find(params[:id])
    @period.destroy
    flash[:notice] = "Successfully destroyed period."
    redirect_to periods_url
  end
end
