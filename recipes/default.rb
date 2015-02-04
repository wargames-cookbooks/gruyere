# -*- coding: utf-8 -*-
#
# Cookbook Name:: gruyere
# Recipe:: default
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

# Gruyere Install
gruyere_dl_url = 'http://google-gruyere.appspot.com/gruyere-code.zip'
gruyere_local = "#{Chef::Config[:file_cache_path]}/gruyere.zip"

package 'unzip'

remote_file gruyere_local do
  source gruyere_dl_url
end

directory node['gruyere']['path'] do
  recursive true
end

execute 'unzip-gruyere' do
  cwd node['gruyere']['path']
  command "unzip -u #{gruyere_local}"
end

execute 'chmod-executable' do
  cwd node['gruyere']['path']
  command 'chmod u+x gruyere.py'
end

execute 'fix-shebang' do
  cwd node['gruyere']['path']
  command 'sed -i "1 s/^.*$/#!\\/usr\\/bin\\/env python/g" gruyere.py'
end

# TODO: Use template to avoid hardcoding!
cookbook_file '/etc/init.d/gruyere' do
  source 'gruyere_service'
  mode '0755'
end

execute 'update-rc.d gruyere defaults'

service 'gruyere' do
  action :start
end
