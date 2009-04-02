class Package < ActiveRecord::Base
  has_many :details, :classname => 'PackageDetails'
end
