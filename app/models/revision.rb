class Revision < ActiveRecord::Base
  has_many :build_results
  belongs_to :branch

  attr_accessible :branch_id, :sha

  def good?
    builds = branch.builds(:conditions => { :enabled => true} )
    branch_build_names = builds.collect(&:name)
    revisions = results_for(builds)
    revision_build_names = revisions.collect(&:build).collect(&:name)

    return false unless branch_build_names.sort == revision_build_names.sort

    results = revisions.map(&:result)
    return false if results.include? 'FAILURE'

    true
  end

  protected

  def results_for(builds)
    build_results.find(:all, :conditions => {:build_id => builds.map(&:id) })
  end

end
