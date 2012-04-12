class Revision < ActiveRecord::Base
  has_many :revision_builds
  has_many :builds, :through => :revision_builds
  has_many :build_results
end
