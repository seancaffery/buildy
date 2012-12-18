class Revision < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

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

    builds = branch.builds
    branch_build_names = builds.collect(&:name)
    build_results = results_for(builds)
    revision_build_names = build_results.collect(&:build).collect(&:name)

    results = build_results.map(&:result)
    return @status = BAD if results.include? 'FAILURE'
    return @status = UNKNOWN if results.include? 'ABORTED'

    return @status = UNKNOWN if builds.empty?
    return @status = UNKNOWN unless branch_build_names.sort == revision_build_names.sort

    @status = GOOD
  end

  def wall_time
    results = results_for(branch.builds)
    return 0 if results.empty?

    start_time = results.sort_by(&:timestamp).first.timestamp
    endtime = results.map do |result|
      result.timestamp + result.build_time
    end.sort.last

    total_minutes = ((endtime - start_time) / 1000 / 60).to_i

    time_ago_in_words(total_minutes.minutes.ago)
  end

  def display_time
    results = results_for(branch.builds)
    times_in_minutes = results.map do |result|
      result.build_time.to_i / 1000 / 60
    end
    total_minutes = times_in_minutes.inject(0, :+)

    time_ago_in_words(total_minutes.minutes.ago)
  end

  protected

  def results_for(builds)
    build_results.where(:build_id => builds.map(&:id))
  end

end
