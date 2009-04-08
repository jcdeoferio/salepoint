class User < ActiveRecord::Base
  belongs_to :branch, :class_name => "Branch", :foreign_key => "branch_id"
  has_many :xacts
  
  validates_presence_of :userid
  validates_presence_of :role
  validates_presence_of :first_name
  validates_presence_of :last_name
end
