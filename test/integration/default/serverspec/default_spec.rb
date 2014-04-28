require "spec_helper"

describe file("/etc/init.d/gruyere") do
  it { should be_file}
end

describe file("/opt/gruyere/gruyere.py") do
  it { should be_file}
end

describe service('gruyere') do
  it { should be_enabled }
  it { should be_running }
end
