require 'spec_helper'

describe BuildResult do
  describe "display time" do
    it "returns the build time in words" do
      result = BuildResult.new
      result.build_time = 3484263

      result.display_time.should == 'about 1 hour'
    end
  end

end
