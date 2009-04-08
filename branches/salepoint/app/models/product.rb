class Product < ActiveRecord::Base
  has_many :product_details
  has_many :xact_details
  has_many :product_branches
  
  validates_presence_of :product_name
  validates_presence_of :unit_price
end
