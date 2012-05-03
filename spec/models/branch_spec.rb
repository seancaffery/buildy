require 'spec_helper'

describe Branch do

  context "#last_good_revision" do
    let(:branch) { Branch.make! }

    it 'returns nothing where no good revision found' do
      revision = stub(:good? => false,
                      :build_results => [stub(:build_id => 1)])
      branch.stub(:revisions) { [revision] }
      branch.last_good_revision.should be_nil
    end

    it 'returns the last good revision in a set' do
      branch = Branch.make!
      branch.stub(:builds) { [stub(:id => 1)] }
 
      other_good = stub(:good? => true,
                      :created_at => Date.new(2012, 1, 13),
                      :sha => Digest::SHA2.new << rand.to_s,
                      :build_results => [stub(:build_id => 1)])
      bad = stub(:good? => false,
                      :created_at => Date.new(2012, 1, 14),
                      :sha => Digest::SHA2.new << rand.to_s,
                      :build_results => [stub(:build_id => 1)])
      good_bro = stub(:good? => true,
                      :created_at => Date.new(2012, 1, 15),
                      :sha => Digest::SHA2.new << rand.to_s,
                      :build_results => [stub(:build_id => 1)])

      branch.stub(:revisions) { [good_bro, bad, other_good] }

      branch.last_good_revision.should == good_bro.sha
    end

  end
end
