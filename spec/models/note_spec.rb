require 'spec_helper'

describe Note do
  describe "#body" do
    it "should remove carriage returns" do
      note = Note.new(
        body: "Cool\n\rSuper"
      )
      note.body.should == "Cool\nSuper"
    end
  end

  describe "#to_json" do
    it "should return the right data" do
      note = Note.new(
        name: "Super Cool",
        body: "It's ok",
        deadline: true
      )
      citation = note.citations.build(
        message: "Message",
        range_start: 0,
        range_end: 10
      )
      note.to_json.should == {
        deadline: true,
        name: "Super Cool",
        body: "It's ok",
        citations: [citation.to_json]
      }
    end
  end
end
