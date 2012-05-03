require 'spec_helper'

describe Revision do
  let(:revision) { Revision.new }

  it "determines a good build" do
    revision.stub_chain(:branch, :builds) { [stub(:name => 'build')] }
    revision.stub(:build_results) { [stub(:result => 'SUCCESS',
                                         :build => stub(:name => 'build'))] }

    revision.good?.should be_true
  end

  it "determines a bad build" do
    revision.stub_chain(:branch, :builds) { [stub(:name => 'build')] }
    revision.stub(:build_results) { [stub(:result => 'FAILURE',
                                         :build => stub(:name => 'build'))] }

    revision.good?.should be_false
  end
end
