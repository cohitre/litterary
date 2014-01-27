require "spec_helper"

describe User do
  describe ".create" do
    it "should not allow creation without a login" do
      User.create()
    end
  end

  describe "login_validation" do
    it "should allow multiple formats" do
      user = User.new(
        login: "c",
        password: "cool"
      )

    end
  end
end
