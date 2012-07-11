class Period < ActiveRecord::Base
  belongs_to :account
  has_many :reviews
  has_many :users, :through => :reviews
  
  before_create :check_active
  after_create :change_period_state
  after_update :close_reviews
  
  validates :account_id, :name, :start_date, :end_date, :presence => true
  
  state_machine :initial => :unregistered do    
    event :opener do
      transition :unregistered => :open
    end
    
    event :close do
      transition :open => :closed
    end
  end
  
  attr_accessible :account_id, :end_date, :name, :start_date, :state
  
  private
  
  def check_active
    account.periods.find_by_state("open").nil? ? true : false
  end
  
  def change_period_state
    p = self
    p.opener
    
    users = User.find(:all, :conditions => { :account_id => p.account_id })
    
    users.each do |user|
      review = Review.find(:all, :conditions => { :state => "open", :user_id => user.id }).count
      
      if review > 0
        return
      else      
        review = Review.create(:account_id => p.account_id,
                                :period_id => p.id,
                                :user_id => user.id)
      end
    end
  end
  
  def close_reviews
    p = self
    if p.state == "closed"
      #close all reviews for this period
      reviews = Review.find(:all, :conditions => { :period_id => self })
    
      reviews.each do |review|
        review.closer
      end
      
      #then create a default period and reviews for all users
      period = Period.create(:name => "**Default Period**",
                           :start_date => Date.today,
                           :end_date => Date.today,
                           :account_id => self.account_id)
    end
  end
end
