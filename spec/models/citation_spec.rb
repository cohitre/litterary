require "spec_helper"

describe Citation do
  describe "#to_json" do
    it "should show the right information" do
      a = Citation.new(
        message: "Cool comment",
        range_begin: 10,
        range_end: 15
      )
      a.to_json.should == {
        :id => nil,
        :comment => "Cool comment",
        :range => {
          :start => 10,
          :end => 15
        }
      }
    end
  end
end
