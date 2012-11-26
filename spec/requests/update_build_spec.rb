require 'spec_helper'
require 'json'

describe "Update build" do
  context "branch and build exist" do
    it "creates a build result with given data" do
      branch = Branch.create(:name => 'master')
      branch.builds.create(:name => 'lol')
      build_info = {'branch' => 'master', 'build_name' => 'lol',
                    'revision_id' => 'sha', 'result' => 'SUCCESS',
                    'duration' => '30000', 'timestamp' => '1335880880258'}

      post 'update_build', :payload => JSON.dump(build_info)

      response.status.should == 200
      result = BuildResult.last
      result.result.should == 'SUCCESS'
      result.build_time.should == 30000
      result.timestamp.should == 1335880880258
    end
  end

  context "build does not exist" do
    it "responds with unprocessable entity" do
      build_info = {'branch' => 'master', 'build_name' => 'lol',
                    'revision_id' => 'sha', 'result' => 'SUCCESS',
                    'duration' => '30000'}

      post 'update_build', :payload => JSON.dump(build_info)
      response.status.should == 422
    end
  end
end
