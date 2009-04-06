class Product < ActiveRecord::Base
  has_many :product_details
  has_many :xact_details
  has_many :product_branches
end
