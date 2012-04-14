class Branch < ActiveRecord::Base
  has_many :builds
  has_many :revisions
end
