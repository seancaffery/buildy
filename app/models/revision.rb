class Revision < ActiveRecord::Base
  has_many :build_results
  belongs_to :branch

  attr_accessible :branch_id, :sha

  GOOD = 'good'
  BAD = 'bad'
  UNKOWN = 'unkown'

  def good?
    status == GOOD
  end

  def status
    return @status if @status

    builds = branch.builds(:conditions => { :enabled => true} )
    branch_build_names = builds.collect(&:name)
    revisions = results_for(builds)
    revision_build_names = revisions.collect(&:build).collect(&:name)

    return @status = UNKOWN if builds.empty?
    return @status = UNKOWN unless branch_build_names.sort == revision_build_names.sort

    results = revisions.map(&:result)
    return @status = UNKOWN if results.include? 'ABORTED'
    return @status = BAD if results.include? 'FAILURE'

    @status = GOOD
  end

  protected

  def results_for(builds)
    build_results.find(:all, :conditions => {:build_id => builds.map(&:id) })
  end

end
