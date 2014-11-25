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
  "-N PING",
  "-A PING -p icmp --icmp-type 8 -j ACCEPT",
  "-A PING -p icmp --icmp-type 11 -j ACCEPT",
  "-A INPUT  -j PING",
  "-A OUTPUT -j PING",
  "",
  "# locale interface",
  "-A INPUT  -i lo -j ACCEPT",
  "-A OUTPUT -o lo -j ACCEPT",
  "",
  "# Already connected:",
  "-A INPUT  -m state --state ESTABLISHED,RELATED -j ACCEPT",
  "-A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT",
  ""
]

default['chef-iptables']['ipv4rules']['filter']['INPUT']['ssh'] = '--protocol tcp --dport 22 --sport 1024:65535 --match state --state NEW --jump ACCEPT'
default['chef-iptables']['ipv4rules']['filter']['OUTPUT']['dns'] = '--protocol udp --dport 53 --jump ACCEPT'
default['chef-iptables']['ipv4rules']['filter']['FORWARD']['default'] = nil

default['chef-iptables']['ipv4rules']['nat']['OUTPUT']['default'] = nil
default['chef-iptables']['ipv4rules']['nat']['PREROUTING']['default'] = nil
default['chef-iptables']['ipv4rules']['nat']['POSTROUTING']['default'] = nil

default['chef-iptables']['ipv4rules']['mangle']['INPUT']['default'] = nil
default['chef-iptables']['ipv4rules']['mangle']['OUTPUT']['default'] = nil
default['chef-iptables']['ipv4rules']['mangle']['FORWARD']['default'] = nil
default['chef-iptables']['ipv4rules']['mangle']['PREROUTING']['default'] = nil
default['chef-iptables']['ipv4rules']['mangle']['POSTROUTING']['default'] = nil

default['chef-iptables']['ipv4rules']['raw']['OUTPUT']['default'] = nil
default['chef-iptables']['ipv4rules']['raw']['PREROUTING']['default'] = nil
