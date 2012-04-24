class BuildResult < ActiveRecord::Base
  belongs_to :revision
  belongs_to :build

  attr_accessible :build_id, :result, :revision_id
end
