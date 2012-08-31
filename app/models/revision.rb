class Revision < ActiveRecord::Base
  has_many :build_results
  belongs_to :branch

  attr_accessible :branch_id, :sha

  GOOD = 'good'
  BAD = 'bad'
  UNKNOWN = 'unknown'

  def good?
    status == GOOD
  end

  def status
    return @status if @status

    builds = branch.builds(:conditions => { :enabled => true} )
    branch_build_names = builds.collect(&:name)
    revisions = results_for(builds)
    revision_build_names = revisions.collect(&:build).collect(&:name)

    results = revisions.map(&:result)
    return @status = BAD if results.include? 'FAILURE'
    return @status = UNKNOWN if results.include? 'ABORTED'

    return @status = UNKNOWN if builds.empty?
    return @status = UNKNOWN unless branch_build_names.sort == revision_build_names.sort

    @status = GOOD
  end

  protected

  def results_for(builds)
    build_results.find(:all, :conditions => {:build_id => builds.map(&:id) })
  end

end
