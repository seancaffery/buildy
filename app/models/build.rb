class Build < ActiveRecord::Base
  belongs_to :branch

  attr_accessible :branch_id, :name
end
