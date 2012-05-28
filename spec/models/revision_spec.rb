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
end
