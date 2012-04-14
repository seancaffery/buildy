class Revision < ActiveRecord::Base
  has_many :build_results
  belongs_to :branch
end
