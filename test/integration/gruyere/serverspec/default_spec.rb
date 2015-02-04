# -*- coding: utf-8 -*-

require 'serverspec'
set :backend, :exec

describe file('/opt/gruyere') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }
end

describe file('/etc/init.d/gruyere') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }
end

describe file('/opt/gruyere/gruyere.py') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }
end

describe service('gruyere') do
  it { should be_enabled }
  it { should be_running }
end

describe port 8008 do
  it { should be_listening }
end

describe command('wget -O - http://127.0.0.1:8008') do
  its(:stdout) { should match /Gruyere: Home/ }
end
