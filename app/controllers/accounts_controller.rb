class AccountsController < ApplicationController  
  def new
    @account = Account.new
    @account.users.build # build a blank user or the child form won't display
    @account.user_limit = params[:user_limit]
  end

  def create
    @account = Account.new(params[:account])
    
    if @account.save
      flash[:notice] = "Account created"
      redirect_to root_url #redirect to welcome page
    else
      render 'new'
    end
  end
  
  def edit
    @account = Account.find(params[:id])
    @admins = User.find(:all, :conditions => { :account_id => current_user.account_id, :role => "admin" })
  end
  
  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account])
      flash[:notice] = "Successfully updated account."
      redirect_to dashboards_path
    else
      render :action => 'edit'
    end
  end
end
