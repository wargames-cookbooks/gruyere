# -*- coding: utf-8 -*-

require 'spec_helper'

describe 'gruyere::apache2_proxy' do
  let(:subject) do
    ChefSpec::SoloRunner.new(file_cache_path: '/var/chef/cache') do |node|
      node.override['gruyere']['path'] = '/opt/gruyere-app'
      node.override['gruyere']['apache2']['site_name'] = 'gruyere-app-proxy'
      node.override['gruyere']['apache2']['server_name'] = 'gruyere-app'
      node.override['gruyere']['apache2']['server_aliases'] = ['gruyere-app2']
    end.converge(described_recipe)
  end

  # before do
  #   stub_command('/usr/sbin/apache2 -t').and_return(true)
  # end

  it 'includes recipe[gruyere::default]' do
    expect(subject).to include_recipe('gruyere::default')
  end

  it 'installs apache2_install[gruyere-app-proxy]' do
    expect(subject).to install_apache2_install('gruyere-app-proxy')
  end

  it 'starts service[apache2]' do
    expect(subject).to start_service('apache2')
  end

  it 'enables service[apache2]' do
    expect(subject).to enable_service('apache2')
  end

  it 'creates directory[gruyere-app-proxy]' do
    expect(subject).to create_directory('gruyere-app-proxy')
      .with(recursive: true,
            path: '/var/www/html/gruyere-app-proxy')
  end

  it 'creates template[gruyere-app-proxy]' do
    expect(subject).to create_template('gruyere-app-proxy')
      .with(source: 'site.conf.erb',
            path: '/etc/apache2/sites-available/gruyere-app-proxy.conf')
  end

  it 'enables apache2_site[gruyere-app-proxy]' do
    expect(subject).to enable_apache2_site('gruyere-app-proxy')
  end

  it 'disables apache2_site[000-default]' do
    expect(subject).to disable_apache2_site('000-default')
  end

  it 'enables apache2_module[proxy]' do
    expect(subject).to enable_apache2_module('proxy')
  end

  it 'enables apache2_module[proxy_http]' do
    expect(subject).to enable_apache2_module('proxy_http')
  end
end
