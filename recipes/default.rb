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

%w( ufw iptables-persistent ).each do |package|
  package package do
    action :remove
    only_if { node['platform_family'] == 'debian' }
  end
end

package 'iptables' do
  action :install
end

package 'iptables-ipv6' do
  action :install
  only_if { node['platform_family'] == 'rhel' }
end

i=1; while i do
  i = node['chef-iptables']['confdir'].sub(/\/$/, '').index('/', i)
  mode = '0755'
  if i
    filename = node['chef-iptables']['confdir'][0..i]; i += 1
  else
    filename = node['chef-iptables']['confdir']
    mode = '0700'
  end

  directory filename do
    owner 'root'
    group 'root'
    mode mode
    action :create
  end
end

def makeRulefile( filename, rule )
  if rule
    content = ""
    if rule.is_a? Array
         rule.each do |i|; content += i + "\n"; end
    else content += rule
    end

    file "#{filename}" do
      owner   'root'
      group   'root'
      mode    00600
      content content
      action  :create
    end
  end
end

node['chef-iptables'].each do |ipvName, ipv|
  ext = ipvName=='ipv4rules' ? 'ipv4' : ( ipvName=='ipv6rules' ? 'ipv6' : '' )
  if ipvName == 'rules' || ipvName == 'ipv4rules' || ipvName == 'ipv6rules'

    ipv.each do |tableName, table|
      filename = "#{node['chef-iptables']['confdir'].sub(/\/$/, '')}/#{tableName}"

      if table.is_a? Hash
        directory filename do
          owner  'root'
          group  'root'
          mode   00700
          not_if { ::File.exist?( filename ) }
        end

        table.each do |chainName, chain|
          directory "#{filename}/#{chainName}" do
            owner  'root'
            group  'root'
            mode   00700
            not_if { ::File.exist?( "#{filename}#{chainName}" ) }
          end

          chain.each do |ruleName, rule|
            makeRulefile( filename + '/' + chainName + '/' + ruleName + '.' + ext, rule )
          end
        end
      else
        makeRulefile( filename + '.' + ext, table )
      end
    end

  end
end

cookbook_file '/etc/init.d/iptables-persistent' do
  source 'iptables-persistent'
  owner 'root'
  group 'root'
  mode 00700
end

service 'iptables-persistent' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :restart ]
end
