require 'digest/sha2'
require 'machinist/active_record'

Build.blueprint do
  name { 'buildy' }
end

Revision.blueprint do
  sha { Digest::SHA2.new << rand.to_s }
end

Branch.blueprint do
  name { 'branch' }
end
