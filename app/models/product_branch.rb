class ProductBranch < ActiveRecord::Base
  belongs_to :product, :class_name => "Product", :foreign_key => "product_id"
  belongs_to :branch, :class_name => "Branch", :foreign_key => "branch_id"
end
