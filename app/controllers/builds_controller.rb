require 'json'

class BuildsController < ApplicationController
  # GET /builds
  # GET /builds.json
  def index
    @builds = Build.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @builds }
    end
  end

  # GET /builds/1
  # GET /builds/1.json
  def show
    @build = Build.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @build }
    end
  end

  # GET /builds/new
  # GET /builds/new.json
  def new
    @build = Build.new
    @branch = Branch.find(params[:branch_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @build }
    end
  end

  # GET /builds/1/edit
  def edit
    @build = Build.find(params[:id])
    @branch = Branch.find(params[:branch_id])
  end

  # POST /builds
  # POST /builds.json
  def create
    @build = Build.new(params[:build])
    branch = Branch.find(params[:branch_id])
    @build.branch = branch

    respond_to do |format|
      if @build.save
        format.html { redirect_to [branch, @build], :notice => 'Build was successfully created.' }
        format.json { render :json => @build, :status => :created, :location => @build }
      else
        format.html { render :action => "new" }
        format.json { render :json => @build.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /builds/1
  # PUT /builds/1.json
  def update
    @build = Build.find(params[:id])
    @build.branch = Branch.find(params[:branch_id])

    respond_to do |format|
      if @build.update_attributes(params[:build])
        format.html { redirect_to @build, :notice => 'Build was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @build.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /builds/1
  # DELETE /builds/1.json
  def destroy
    @build = Build.find(params[:id])
    @build.destroy

    respond_to do |format|
      format.html { redirect_to branch_builds_url }
      format.json { head :no_content }
    end
  end

  def update_build
    build_info = JSON.parse(params[:payload])

    branch = Branch.find_or_create_by_name(build_info['branch'].gsub('/', '_'))
    build = branch.builds.find_by_name(build_info['build_name'])

    if build
      revision = branch.revisions.find_or_create_by_sha(build_info['revision_id'])
      build_result = revision.build_results.find_or_create_by_revision_id_and_build_id(revision.id, build.id)
      build_result.result = build_info['result']
      build_result.save!
      render :nothing => true
      return
    else
      render :nothing => true, :status => 422
      return
    end

  end
end
