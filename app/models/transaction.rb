class Transaction < ActiveRecord::Base
  belongs_to :type, :class_name => "Transaction_type", :foreign_key => "type_id"
  belongs_to :branch, :class_name => "Branch", :foreign_key => "branch_id"
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
end
