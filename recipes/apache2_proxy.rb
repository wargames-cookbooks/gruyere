# -*- coding: utf-8 -*-
#
# Cookbook:: gruyere
# Recipe:: apache2_proxy
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'gruyere::default'

sitename = node['gruyere']['apache2']['site_name']

apache2_install sitename

service 'apache2' do
  extend Apache2::Cookbook::Helpers
  service_name lazy { apache_platform_service_name }
  supports restart: true, status: true, reload: true
  action [:start, :enable]
end

directory sitename do
  extend Apache2::Cookbook::Helpers
  path "#{default_docroot_dir}/#{sitename}"
  recursive true
end

template sitename do
  extend Apache2::Cookbook::Helpers
  source 'site.conf.erb'
  path "#{apache_dir}/sites-available/#{sitename}.conf"
  variables(
    server_name: node['gruyere']['apache2']['server_name'],
    server_aliases: node['gruyere']['apache2']['server_aliases'],
    log_dir: lazy { default_log_dir },
    site_name: sitename
  )
end

apache2_site sitename

apache2_site '000-default' do
  action :disable
end

apache2_module 'proxy'
