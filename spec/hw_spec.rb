require 'spec_helper'

# Sanity Checks
describe HW do
  it "should expect the correct DIRECTORY" do
    expect(HW::DIRECTORY).to eq '/tmp/gems/hw/fakehome/.hw'
  end

  it "should expect the correct CONFIG_PATH" do
    expect(HW::CONFIG_PATH).to eq '/tmp/gems/hw/fakehome/.hw/config'
  end

  it "should expect the correct SOURCES_PATH" do
    expect(HW::SOURCES_PATH).to eq '/tmp/gems/hw/fakehome/.hw/sources/'
  end
end
