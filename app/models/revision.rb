class Revision < ActiveRecord::Base
  has_many :build_results
  belongs_to :branch

  attr_accessible :branch_id, :sha

  def good?
    branch_build_names = branch.builds.collect(&:name)
    revision_build_names = build_results.collect(&:build).collect(&:name)
    return false unless branch_build_names.sort == revision_build_names.sort

    results = build_results.map(&:result)
    return false if results.include? 'FAILURE'

    true
  end

end
