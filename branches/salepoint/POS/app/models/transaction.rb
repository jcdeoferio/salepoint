class Transaction < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  has_many :details, :class_name => "TransactionDetails"
end
