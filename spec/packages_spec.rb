require "spec_helper"

describe HW::Packages do
  context "self#add"
  context "self#register"
  context "self#list"

  context "self#reserved?" do
    it "should return true if passed 'help'" do
      expect( HW::Packages.reserved?("help") ).to be_true
    end

    it "should return false if passed 'test'" do
      expect( HW::Packages.reserved?("test") ).to be_false
    end
  end
end
