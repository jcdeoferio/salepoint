class Branch < ActiveRecord::Base
  has_many :transactions
  has_many :users
  has_many :product_branches
end
