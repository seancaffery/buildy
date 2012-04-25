class Branch < ActiveRecord::Base
  has_many :builds
  has_many :revisions, :order => 'created_at DESC'

  attr_accessible :name

  def last_good_revision
    revs = []
    revisions.each do |rev|
      next unless rev.build_results.count == builds.count
       revs << rev if rev.good?
    end

    if revs.first
      revs.first.sha
    end
  end
end
