class User < ActiveRecord::Base
  belongs_to :branch, :class_name => "Branch", :foreign_key => "branch_id"
  has_many :transaction
end
