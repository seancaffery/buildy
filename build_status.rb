require 'rubygems'
require 'sinatra'
require 'json'

require 'models'

class BuildStatus #< Sinatra::Base
  get '/' do
    @revisions = Revision.all
  end

  get '/last_good_revision' do
  end

  post '/update_build' do
    build_info = JSON.parse(params[:payload])

    revision = Revision.find_or_create_by_revision_id(build_info['revision_id'])
    build = Build.find_by_name(build_info['build_name'])
    revision.builds << build if revision.new_record?

    revision.build_results.build(:build => build, :result => build_info['revision_id'])
    revision.save!
  end
end
