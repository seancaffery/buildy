class Branch < ActiveRecord::Base
  has_many :builds
  has_many :revisions, :order => :created_at
end
