require "spec_helper"

describe file("/opt/gruyere") do
  it { should be_directory}
end

describe file("/etc/init.d/gruyere") do
  it { should be_file}
end

describe file("/opt/gruyere/gruyere.py") do
  it { should be_file}
end

describe service('apache2') do
  it { should be_enabled }
  it { should be_running }
end

describe service('gruyere') do
  it { should be_enabled }
  it { should be_running }
end
