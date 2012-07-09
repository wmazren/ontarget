class Goal < ActiveRecord::Base
  belongs_to :user
  belongs_to :review
  has_one :progress, :dependent => :destroy
  
  validates :title, :start_date, :due_date, :presence => true
  
  state_machine :state, :initial => :open do
  end
  
  attr_accessible :description, :due_date, :review_id, :start_date, :state, :title, :user_id
end
