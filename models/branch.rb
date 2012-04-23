class Branch < ActiveRecord::Base
  has_many :builds
  has_many :revisions, :order => :created_at

  def last_good_revision
    revs = []
    revisions.each do |rev|
      next unless rev.build_results.count == builds.count
       revs << rev if rev.good?
    end

    if revs.last
      revs.last.revision_id
    end
  end
end
