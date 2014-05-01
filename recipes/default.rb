# encoding: utf-8
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
gruyere_dl_url = "http://google-gruyere.appspot.com/gruyere-code.zip"
gruyere_local = Chef::Config[:file_cache_path] + "/gruyere.zip"

# Install the unzip package
package "unzip" do
    action :install
end

remote_file gruyere_local do
  source gruyere_dl_url
  mode "0644"
end

directory node["gruyere"]["path"] do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

execute "unzip-gruyere" do
  cwd node['gruyere']['path']
  command "unzip " + gruyere_local
end

# Do some changes
execute "chmod executable" do
  cwd node["gruyere"]["path"]
  command "chmod u+x gruyere.py"
end

execute "change python binary" do
  cwd node["gruyere"]["path"]
  command "sed -i '1 s/^.*$/#!\\/usr\\/bin\\/env python/g' gruyere.py"
end

# Create service
cookbook_file "/etc/init.d/gruyere" do
  source "gruyere_service"
  cookbook "gruyere"
end

execute "chmod service" do
  command "chmod +x /etc/init.d/gruyere"
end

execute "update service" do
  command "update-rc.d gruyere defaults"
end

service "gruyere" do
    action :start
end
