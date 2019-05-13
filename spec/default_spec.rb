# -*- coding: utf-8 -*-

require 'spec_helper'

describe 'gruyere::default' do
  let(:subject) do
    ChefSpec::SoloRunner.new(file_cache_path: '/var/chef/cache',
                             platform: 'debian',
                             version: '9.5') do |node|
      node.override['gruyere']['path'] = '/opt/gruyere-app'
    end.converge(described_recipe)
  end

  it 'should install unzip package' do
    expect(subject).to install_package('unzip')
  end

  it 'should download gruyere source code' do
    expect(subject).to create_remote_file('/var/chef/cache/gruyere.zip')
  end

  it 'should create gruyere directory' do
    expect(subject).to create_directory('/opt/gruyere-app')
      .with(recursive: true)
  end

  it 'should unzip gruyere archive in created directory' do
    expect(subject).to run_execute('unzip-gruyere')
      .with(cwd: '/opt/gruyere-app',
            command: 'unzip -u /var/chef/cache/gruyere.zip')
  end

  it 'should set correct perms for gruyere.py' do
    expect(subject).to run_execute('chmod-executable')
      .with(cwd: '/opt/gruyere-app',
            command: 'chmod u+x gruyere.py')
  end

  it 'should fix gruyere.py Shebang' do
    expect(subject).to run_execute('fix-gruyere-shebang')
  end

  it 'should create service from template' do
    service = '/etc/init.d/gruyere'
    expect(subject).to create_template(service)
      .with(source: 'gruyere.erb',
            mode: '0755')
    expect(subject).to render_file(service).with_content(
      %r{DAEMON=/opt/gruyere-app/gruyere.py})
  end

  it 'should init gruyere service' do
    expect(subject).to run_execute('update-rc.d gruyere defaults')
  end

  it 'should start gruyere service' do
    expect(subject).to start_service('gruyere')
  end
end
