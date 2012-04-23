class Branch < ActiveRecord::Base
  has_many :builds
  has_many :revisions, :order => :created_at

  def last_good_revision(branch)
    revs = []
    revisions.each do |rev|
      next unless rev.build_results.count == branch.builds.count
      build_results = rev.build_results.map(&:result)
      revs <<  rev unless build_results.include? 'failed'
    end

    if revs.last
      revs.last.revision_id
    end
  end
end
