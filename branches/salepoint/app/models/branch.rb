class Branch < ActiveRecord::Base
  has_many :xacts
  has_many :users
  has_many :product_branches
  
  validates_presence_of :branch_name
  validates_presence_of :branch_address
end
