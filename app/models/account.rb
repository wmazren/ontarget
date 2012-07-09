class Account < ActiveRecord::Base
  has_many :users, :inverse_of => :account, :dependent => :destroy
  has_many :periods
  has_many :reviews
  
  accepts_nested_attributes_for :users
  
  attr_accessible :name, :subdomain, :user_limit, :users_attributes,
                  :phone, :fax, :address1, :address2, :city, :postcode, :state, :country
  
  private
end
