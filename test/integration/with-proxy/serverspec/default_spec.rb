# -*- coding: utf-8 -*-

require 'serverspec'
set :backend, :exec

describe service('apache2') do
  it { should be_enabled }
  it { should be_running }
end

describe service('gruyere') do
  it { should be_enabled }
  it { should be_running }
end

describe port 80 do
  it { should be_listening }
end

describe command('wget -O - http://127.0.0.1') do
  its(:stdout) { should match /Gruyere: Home/ }
end
