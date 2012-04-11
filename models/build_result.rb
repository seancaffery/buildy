class BuildResult < ActiveRecord::Base
  belongs_to :revision
  belongs_to :build
end
