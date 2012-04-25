require 'spec_helper'

describe Branch do

  context "#last_good_revision" do

    it 'returns nothing where no good revision found'

    it 'returns the last good revision in a set' do
      @branch = Branch.make!
      other_good = Revision.make!
      bad = Revision.make!
      good_bro = Revision.make!
      @branch.revisions << [other_good, bad, good_bro]

      @branch.last_good_revision.should == good_bro.sha
    end

  end
end
