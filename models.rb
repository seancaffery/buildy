require 'active_record'
require 'sinatra/activerecord'

require 'models/revision'
require 'models/build'
require 'models/build_result'
require 'models/revision_build'
require 'models/branch'

configure :development do
  set :database, 'sqlite://dev.sqlite3'
end

configure :production do
  set :database, 'sqlite://production.sqlite3'
end
