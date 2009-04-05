class Product < ActiveRecord::Base
  has_many :details, :class_name => "ProductDetails"
  has_many :tdetails, :class_name => "TransactionDetails"
  has_many :product_branches
end
