#
# Cookbook Name:: chef-iptables
# Attributes:: chef-iptables
#
default['chef-iptables']['confdir'] = '/etc/iptables.d/'

default['chef-iptables']['rules']['default'] = [
  "-P INPUT   DROP",
  "-P OUTPUT  DROP",
  "-P FORWARD DROP",
  "",
  "# PING",
  "-t filter -N PING",
  "-t filter -A PING -p icmp --icmp-type 8 -j ACCEPT",
  "-t filter -A PING -p icmp --icmp-type 11 -j ACCEPT",
  "-t filter -A PING --match limit --limit 6/min --j ACCEPT",
  "-t filter -A INPUT  -j PING",
  "-t filter -A OUTPUT -j PING",
  "",
  "# locale interface",
  "-t filter -A INPUT  -i lo -j ACCEPT",
  "-t filter -A OUTPUT -o lo -j ACCEPT",
  "",
  "# Already connected:",
  "-t filter -A INPUT  -m state --state ESTABLISHED,RELATED -j ACCEPT",
  "-t filter -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT",
  ""
]

default['chef-iptables']['ipv4rules']['filter']['INPUT']['ssh'] = '--protocol tcp --dport 22 --sport 1024:65535 --match state --state NEW --jump ACCEPT'
default['chef-iptables']['ipv4rules']['filter']['OUTPUT']['dns'] = '--protocol udp --dport 53 --jump ACCEPT'
default['chef-iptables']['ipv4rules']['filter']['OUTPUT']['ntp'] = '--protocol udp --dport 123 --jump ACCEPT'
default['chef-iptables']['ipv4rules']['filter']['OUTPUT']['apt-cacher-nt'] = '--protocol tcp --dport 3142 --jump ACCEPT'
default['chef-iptables']['ipv4rules']['filter']['FORWARD']['default'] = nil

default['chef-iptables']['ipv4rules']['nat']['PREROUTING']['default'] = nil
default['chef-iptables']['ipv4rules']['nat']['POSTROUTING']['default'] = nil

default['chef-iptables']['ipv4rules']['mangle']['INPUT']['default'] = nil
default['chef-iptables']['ipv4rules']['mangle']['OUTPUT']['default'] = nil
default['chef-iptables']['ipv4rules']['mangle']['FORWARD']['default'] = nil
default['chef-iptables']['ipv4rules']['mangle']['PREROUTING']['default'] = nil
default['chef-iptables']['ipv4rules']['mangle']['POSTROUTING']['default'] = nil

default['chef-iptables']['ipv4rules']['raw']['OUTPUT']['default'] = nil
default['chef-iptables']['ipv4rules']['raw']['PREROUTING']['default'] = nil

