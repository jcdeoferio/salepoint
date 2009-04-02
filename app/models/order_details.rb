class OrderDetails < ActiveRecord::Base
  belongs_to :t, :class_name => "Transaction", :foreign_key => "t_id"
  belongs_to :product, :class_name => "Product", :foreign_key => "product_id"
end
