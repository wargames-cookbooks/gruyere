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
# Recipe:: apache2_proxy
#

if platform_family?("debian")
  include_recipe "apt"
end

include_recipe "gruyere::default"
include_recipe "apache2"
include_recipe "apache2::mod_proxy_http"

apache_site "default" do
  enable false
end

web_app "gruyere" do
  cookbook "gruyere"
  enable true
  server_name node["gruyere"]["apache2"]["server_name"]
  server_aliases node["gruyere"]["apache2"]["server_aliases"]
end
