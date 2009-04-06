class Branch < ActiveRecord::Base
  has_many :xacts
  has_many :users
  has_many :product_branches
end
