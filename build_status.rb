require 'rubygems'
require 'sinatra'
require 'json'

require 'models'

class BuildStatus < Sinatra::Base
  get '/' do
    @revisions = Revision.all
  end

  get '/:branch/last_good_revision' do
    branch = Branch.find_by_name params[:branch]
    if branch
     branch.last_good_revision 
    end
  end

  post '/update_build' do
    build_info = JSON.parse(params[:payload])

    branch = Branch.find_by_name(build_info['branch'].gsub('/', '_'))
    revision = branch.revisions.find_or_create_by_revision_id(build_info['revision_id'])
    build = Build.find_by_name(build_info['build_name'])

    build_result = revision.build_results.find_or_create_by_revision_id_and_build_id(revision.id, build.id)
    build_result.result = build_info['result']
    build_result.save!
  end
end
