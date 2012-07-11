class Goal < ActiveRecord::Base
  belongs_to :user
  belongs_to :review
  has_one :progress, :dependent => :destroy
  
  validates :title, :start_date, :due_date, :presence => true
  
  after_create :change_goal_state
  
  state_machine :initial => :unregistered do
    event :opener do
      transition :unregistered => :open
    end
    
    event :closer do
      transition :open => :closed
    end
  end
  
  attr_accessible :description, :due_date, :review_id, :start_date, :state, :title, :user_id
  
  private
  
  def change_goal_state
    self.opener
  end
end
