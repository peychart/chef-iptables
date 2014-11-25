#
# Cookbook Name:: chef-iptables
# Recipe:: default
#
# Copyright (C) 2014 PE, pf.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Make sure ufw is not installed on Ubuntu/Debian, as it might interfere

package 'iptables' do
  package_name iptables
  action :install
end

package 'iptables-ipv6' do
  package_name iptables-ipv6
  action :install
  only_if { node['platform_family'] == 'rhel' }
end

package 'ifw' do
  package_name ifw
  action :remove
  only_if { node['platform_family'] == 'debian' }
end

package 'iptables-persistent' do
  package_name iptables-persistent
  action :remove
  only_if { node['platform_family'] == 'debian' }
end

i=1; while i do
  i = node['chef-iptables']['confdir'].sub(/\/$/, '').index('/', i)
  mode='0755'
  if i
    filename = node['chef-iptables']['confdir'][0..i]; i += 1
  else
    filename = node['chef-iptables']['confdir']
    mode='0700'
  end
  directory filename do
    owner 'root'
    group 'root'
    mode mode
    action :create
  end
end

node['chef-iptables'].each do |ipv|

  if ipv.is_a? Array
    filename = ipv.each do |table|

      directory "/etc/iptables.d/#{table}" do
        owner  'root'
        group  'root'
        mode   00700
        not_if { ::File.exist?( "/etc/iptables.d/#{table}" ) }
      end

      table.each do |chain|

        directory "/etc/iptables.d/#{table}/#{chain}" do
          owner  'root'
          group  'root'
          mode   00700
          not_if { ::File.exist?( "/etc/iptables.d/#{table}/#{chain}" ) }
        end

        "#{default['chef-iptables']['confdir']}/#{table}/#{chain}"
      end
    end
  else
    filename = "#{default['chef-iptables']['confdir']}/#{table}"
  end

  if ipv == "ipv4rules"
    filename += ".ipv4"
  elsif ipv == "ipv6rules"
    filename += ".ipv6"
  end

  chain.each do |rule|
    r = ""
    if rule.is_a? Array
         r +=  rule.each do |i|; i; end
    else r += rule
    end

    file "#{filename}" do
      owner    'root'
      group    'root'
      mode     00600
      content  r
      action   :create
    end

  end

end
