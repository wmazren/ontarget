class Progress < ActiveRecord::Base
  belongs_to :goal, :dependent => :destroy
  belongs_to :user
  
  before_create :set_percent
  
  state_machine :state, :initial => 'new' do
    event :progress do
      transition 'new' => 'in progress'
    end
    
    event :complete do
      transition 'in progress' => 'completed'
    end
  end
  
  attr_accessible :goal_id, :percent_complete, :progress_update, :state, :user_id
  
  private
  
  def set_percent
    self.percent_complete = 0
  end
end
