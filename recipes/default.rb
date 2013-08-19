# This source file is part of Gruyere's chef cookbook.
#
# Gruyere's chef cookbook is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Gruyere's chef cookbook is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with Gruyere's chef cookbook. If not, see <http://www.gnu.org/licenses/gpl-3.0.html>.
#
# Cookbook Name:: gruyere
# Recipe:: default
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
