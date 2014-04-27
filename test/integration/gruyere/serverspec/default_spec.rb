require "spec_helper"

describe "default recipe" do

  it 'ensures service is present and executable' do
    file("/etc/init.d/gruyere").must_exist
      .with(:mode, "755")
      .and(:owner, "root")
      .and(:group, "root")
  end

  it 'ensures gruyere is executable' do
    file(node["gruyere"]["path"] + "/gruyere.py").must_exist
      .with(:mode, "766")
  end

  it 'ensures service is running' do
    service("gruyere").must_be_enabled
    service("gruyere").must_be_running
  end
end
