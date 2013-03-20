require "spec_helper"

describe HW::Sources do
  context "self#all" do
    it "should return an empty hash if .hw/config file not found" do
      expect(HW::Sources.all).to eq({})
    end

    it "should return all sources" do
      results = capture(:stdout) { HW::CLI.start(["update", "--pull", "false"]) }
      expected_result = {"default"=>"git@github.com:carrot/hw-packages.git"}
      expect(HW::Sources.all).to eq expected_result
    end
  end

  context "self#local_source?" do
    it "should return true if input is a local path" do
      expect( HW::Sources.local_source?("/tmp") ).to be_true
      expect( HW::Sources.local_source?("./tmp") ).to be_true
      expect( HW::Sources.local_source?("tmp") ).to be_true
      expect( HW::Sources.local_source?(".") ).to be_true
      expect( HW::Sources.local_source?("..") ).to be_true
      expect( HW::Sources.local_source?("tmp/") ).to be_true
    end

    it "should return false if input is a git repository" do
      expect( HW::Sources.local_source?("https://github.com/carrot/hw.git") ).to be_false
      expect( HW::Sources.local_source?("git@github.com:carrot/hw.git") ).to be_false
      # TODO: Doesn't work
      # expect( HW::Sources.local_source?("git://github.com/carrot/hw.git") ).to be_false
    end
  end
end
