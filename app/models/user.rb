class User < ActiveRecord::Base
  belongs_to :account, :inverse_of => :users
  has_many :reviews
  has_many :periods, :through => :reviews
  has_many :goals
  has_many :progresses
  
  validates :account, :presence => true
  validates :username, :first_name, :last_name, :presence => true
  validates :username, :uniqueness => true
  
  validate :account_has_quota
  before_create :decrement_quota_count
  after_create :initialize_period_review
  
  state_machine :initial => :active do
    event :disable do
      transition :active => :disabled
    end
  end
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :username, :first_name, :last_name, :role, :account_id, :current_password
  # attr_accessible :title, :body
  
  private
  
  def initialize_period_review
    period = Period.find_by_account_id_and_state(self.account_id, 'open')
       
    if period.nil?
      period = Period.create(:name => "**Default Period**",
                           :start_date => Date.today,
                           :end_date => Date.today,
                           :account_id => self.account_id)
    else
      review = Review.create(:account_id => self.account_id,
                             :period_id => period.id,
                             :user_id => id)
    end
  end
  
  def account_has_quota
    unless account.user_limit > 0
      errors[:base] << 'You have reached your limit of user.'
  end
  
  def decrement_quota_count
    account.decrement! :user_limit
  end
  end
end
