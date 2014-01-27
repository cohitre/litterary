require "spec_helper"

describe Week do
  describe "published?" do
    it "should be false if the published_at date is in the future" do
      w = Week.new
      w.publishing_date = 5.minutes.from_now
      w.published?.should == false
    end

    it "should be true if the date is in the past" do
      w = Week.new
      w.publishing_date = 5.minutes.ago
      w.published?.should == true
    end
  end
end
