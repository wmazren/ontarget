class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # authorize_resource

  def index
    # for admin dashboard  
    @default_period = Period.find(:all, :conditions => { :account_id => current_user.account_id, :state => "open", :name => "**Default Period**" })
    @default_period_exist = @default_period.count
  
    @user = User.find_by_id(current_user)
    @account = @user.account_id
    @review = Review.find_by_user_id_and_state(current_user, 'open')
    @review_id = Review.find_by_user_id_and_state(current_user, 'open')
    @period_get = Period.find_by_account_id_and_state(@account, 'open')
    # check period for rendering first_time
    @period_for_first_time = Period.find(:all, :conditions => { :account_id => current_user.account_id }).count
        
    if @review.nil?
      @end_date = DateTime.now
    else
      @end_date = @review.period.end_date
    end
    
    if @period_get.nil?
      @period = ''
      @period_start_date = ''
      @period_end_date = ''
    else
      @period = @period_get.name
      @period_start_date = @period_get.start_date
      @period_end_date = @period_get.end_date
    end
    
    @goals = Goal.find_all_by_user_id_and_review_id(current_user, @review_id)
    @goals_total = Goal.find_all_by_user_id_and_review_id(current_user, @review_id).count
    @goals_open = Goal.find(:all, :conditions => { :user_id => current_user, :review_id => @review_id, :state => 'open' }).count
    @goals_closed = Goal.find(:all, :conditions => { :user_id => current_user, :review_id => @review_id, :state => 'closed' }).count
    @goals_in_progress = Goal.find(:all, :conditions => { :user_id => current_user, :review_id => @review_id, :state => 'in progress' }).count
    
    @account_balance = Account.find_by_id(@account).user_limit
    # @account_expires = Account.find_by_id(@account).activated_at
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
