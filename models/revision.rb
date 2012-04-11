class Revision < ActiveRecord::Base
  has_many :builds
  has_many :build_results
end
