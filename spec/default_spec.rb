# -*- coding: utf-8 -*-

require 'spec_helper'

describe 'gruyere::default' do
  let(:subject) do
    ChefSpec::SoloRunner.new(file_cache_path: '/var/chef/cache') do |node|
      node.set['gruyere']['path'] = '/opt/gruyere-app'
    end.converge(described_recipe)
  end

  it 'does install unzip package' do
    expect(subject).to install_package('unzip')
  end

  it 'does download gruyere source code' do
    expect(subject).to create_remote_file('/var/chef/cache/gruyere.zip')
  end

  it 'does create gruyere directory' do
    expect(subject).to create_directory('/opt/gruyere-app')
      .with(recursive: true)
  end

  it 'does unzip gruyere archive in created directory' do
    expect(subject).to run_execute('unzip-gruyere')
      .with(cwd: '/opt/gruyere-app',
            command: 'unzip -u /var/chef/cache/gruyere.zip')
  end

  it 'does set correct perms for gruyere.py' do
    expect(subject).to run_execute('chmod-executable')
      .with(cwd: '/opt/gruyere-app',
            command: 'chmod u+x gruyere.py')
  end

  it 'does fix gruyere.py Shebang' do
    expect(subject).to run_execute('fix-gruyere-shebang')
  end

  it 'does create service from template' do
    service = '/etc/init.d/gruyere'
    expect(subject).to create_template(service)
      .with(source: 'gruyere.erb',
            mode: '0755')
    expect(subject).to render_file(service).with_content(
      %r{DAEMON=/opt/gruyere-app/gruyere.py})
  end

  it 'does init gruyere service' do
    expect(subject).to run_execute('update-rc.d gruyere defaults')
  end

  it 'does start gruyere service' do
    expect(subject).to start_service('gruyere')
  end
end
