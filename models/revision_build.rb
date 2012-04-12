class RevisionBuild < ActiveRecord::Base
  belongs_to :build
  belongs_to :revision
end
