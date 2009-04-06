class XactDetail < ActiveRecord::Base
  belongs_to :xact, :class_name => 'Xact', :foreign_key => 'xact_id'
  belongs_to :product, :class_name => 'Product', :foreign_key => 'product_id'
end
