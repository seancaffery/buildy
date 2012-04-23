class Revision < ActiveRecord::Base
  has_many :build_results
  belongs_to :branch

  def good?
    build_count = branch.builds.count
    return false unless build_results.count == build_count

    results = build_results.map(&:result)
    return false if results.include? 'failed'

    true
  end
end
