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
# Cookbook Name:: gruyere_test
# Recipe:: apache2_proxy
#

describe "gruyere_test::apache2_proxy" do
  include MiniTest::Chef::Resources
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context

  it 'docroot created' do
    directory(node["gruyere"]["path"]).must_exist
  end

  it 'ensures service is present and executable' do
    file("/etc/init.d/gruyere").must_exist
      .with(:mode, "755")
      .and(:owner, "root")
      .and(:group, "root")
  end

  it 'ensures gruyere is executable' do
    file(node["gruyere"]["path"] + "/gruyere.py").must_exist
      .with(:mode, "766")
  end

  it 'ensures service is running' do
    service("gruyere").must_be_enabled
    service("gruyere").must_be_running
  end

  it 'ensures apache2 service is running' do
    service("apache2").must_be_enabled
    service("apache2").must_be_running
  end

end
