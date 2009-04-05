class ProductDetails < ActiveRecord::Base
  belongs_to :product, :class_name => "Product", :foreign_key => "product_id"
  #belongs_to :product, :class_name => "Product", :foreign_key => "pd_id"
end
