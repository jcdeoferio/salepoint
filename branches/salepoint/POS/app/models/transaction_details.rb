class TransactionDetails < ActiveRecord::Base
  belongs_to :transaction, :class_name => "Transaction", :foreign_key => "transaction_id"
  belongs_to :product, :class_name => "Product", :foreign_key => "product_id"
end
