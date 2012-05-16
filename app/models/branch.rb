class Branch < ActiveRecord::Base
  has_many :builds, :conditions => {:enabled => true}
  has_many :revisions, :order => 'created_at DESC'

  attr_accessible :name

  def display_revisions
    revisions.all(:limit => 10)
  end

  def last_good_revision
    revs = []
    build_ids = builds.collect(&:id)

    revisions.each do |rev|
      revision_builds = rev.build_results.collect(&:build_id)
      next unless revision_builds.sort == build_ids.sort
      revs << rev if rev.good?
    end

    if revs.first
      revs.first.sha
    end
  end
end
