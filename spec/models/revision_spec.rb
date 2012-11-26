require 'spec_helper'

describe Revision do
  let(:revision) { Revision.new }

  it "determines a good build" do
    build = stub(:name => 'build', :enabled => true)
    revision.stub_chain(:branch, :builds) { [build] }
    revision.stub(:results_for) { [stub(:result => 'SUCCESS',
                                        :build => build)] }

    revision.good?.should be_true
  end

  it "only includes enabled builds when determining good status" do
    branch = Branch.create(:name => 'hai')
    disabled_build = Build.new(:name => 'disabled')
    disabled_build.enabled = false
    disabled_build.save!
    enabled_build = Build.new(:name => 'enabled')
    enabled_build.enabled = true
    enabled_build.save!

    builds = [ enabled_build, disabled_build ]
    branch.revisions = [revision]
    branch.builds = builds

    revision.stub(:results_for) {
      [stub(:result => 'SUCCESS', :build => enabled_build)]
    }

    revision.good?.should be_true
  end

  it "determines a bad build" do
    build = stub(:name => 'build', :enabled => true)
    revision.stub_chain(:branch, :builds) { [build] }
    revision.stub(:results_for) { [stub(:result => 'FAILURE',
                                        :build => build)] }

    revision.good?.should be_false
  end

  it "marks a revision bad with no builds defined" do
    revision.stub_chain(:branch, :builds).and_return([])
    revision.stub(:results_for).and_return([])
    revision.good?.should be_false
  end

  describe "#status" do

    it "is unknown when there are no active builds" do
      revision.stub_chain(:branch, :builds) { [] }
      revision.status.should == Revision::UNKNOWN
    end

    it "is unkown when revision build names do not match branch build names" do
      build = stub(:name => 'build', :enabled => true)
      revision.stub_chain(:branch, :builds) { [] }
      revision.stub(:results_for) { [stub(:result => 'SUCCESS',
                                          :build => build)] }

      revision.status.should == Revision::UNKNOWN
    end

    it "is unkown when a build is aborted" do
      build = stub(:name => 'build', :enabled => true)
      revision.stub_chain(:branch, :builds) { [build] }
      revision.stub(:results_for) { [stub(:result => 'ABORTED',
                                          :build => build)] }

      revision.status.should == Revision::UNKNOWN
    end

    it "is bad when any build fails" do
      build = stub(:name => 'build', :enabled => true)
      unknown = stub(:name => 'unknown', :enabled => true)
      aborted = stub(:name => 'aborted', :enabled => true)
      revision.stub_chain(:branch, :builds) { [build, unknown, aborted] }
      revision.stub(:results_for) { [stub(:result => 'FAILURE',
                                          :build => build),
                                     stub(:result => 'ABORTED',
                                          :build => aborted)] }

      revision.status.should == Revision::BAD
    end

  end

  describe "#display_time" do
    it "returns the total time taken building a revsion in words" do
      revision = Revision.new
      result_one = revision.build_results.build
      result_one.build_time = 1 * 60 * 1000
      result_two = revision.build_results.build
      result_two.build_time = 2 * 60 * 1000
      result_three = revision.build_results.build
      result_three.build_time = 3 * 60 * 1000

      revision.stub_chain(:branch, :builds)
      revision.stub(:results_for).and_return([result_one, result_two, result_three])

      revision.display_time.should == '6 minutes'
    end
  end

  describe "#wall_time" do
    it "returns minutes elapsed since the first build started and last build ending" do
      start_time = 1353931814000
      revision = Revision.new
      result_one = revision.build_results.build
      result_one.build_time = 1 * 60 * 1000
      result_one.timestamp = start_time
      result_two = revision.build_results.build
      result_two.build_time = 2 * 60 * 1000
      result_two.timestamp = start_time + (1 * 60 * 1000)
      result_three = revision.build_results.build
      result_three.build_time = 3 * 60 * 1000
      result_three.timestamp = start_time

      revision.stub_chain(:branch, :builds)
      revision.stub(:results_for).and_return([result_one, result_two, result_three])

      revision.wall_time.should == '3 minutes'
    end
  end
end
