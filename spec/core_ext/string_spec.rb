require "spec_helper"

describe String do
  context "#to_pkg" do
    it "should convert a string with a single word to a package format" do
      expect("name".to_pkg).to eq "Name"
    end

    it "should convert a string with an underscore to a package string format" do
      expect("package_name".to_pkg).to eq "PackageName"
    end

    it "should convert a string with a forward slash to a package" do
      expect("package/name".to_pkg).to eq "Package::Name"
    end
  end
end
