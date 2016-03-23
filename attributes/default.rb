#
# Cookbook Name:: chef-iptables
# Attributes:: chef-iptables
#
default['chef-iptables']['confdir'] = '/etc/iptables.d/'

default['chef-iptables']['rules']['0default'] = [
  "-P INPUT   DROP",
  "-P OUTPUT  DROP",
  "-P FORWARD DROP",
  "",
  "# locale interface",
  "-t filter -A INPUT  -i lo -j ACCEPT",
  "-t filter -A OUTPUT -o lo -j ACCEPT",
  "",
  "# Already connected:",
  "-t filter -A INPUT  -m state --state ESTABLISHED,RELATED -j ACCEPT",
  "-t filter -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT",
  "",
  "# A BANNIR ABSOLUMENT:",
  "-t filter -A INPUT -s  46.196.0.0/16 -j DROP",
  "-t filter -A INPUT -s  62.212.72.0/24 -j DROP",
  "-t filter -A INPUT -s  69.31.103.106/24 -j DROP",
  "-t filter -A INPUT -s  79.181.240.0/20 -j DROP",
  "-t filter -A INPUT -s  82.192.66.205/24 -j DROP",
  "-t filter -A INPUT -s 173.245.64.0/24 -j DROP",
  "-t filter -A INPUT -s 216.172.135.182/32 -j DROP",
  "-t filter -A INPUT -s 213.140.59.0/24 -j DROP",
  "",
]
default['chef-iptables']['rules']['0default.ipv4'] = [
  "# PING",
  "-t filter -N PING",
  "-t filter -A PING -p icmp --icmp-type echo-request --match limit --limit 6/minute --limit-burst 5 -j ACCEPT",
  "-t filter -A PING -p icmp --icmp-type echo-reply  -j ACCEPT",
  "-t filter -A INPUT  -j PING",
  "-t filter -A OUTPUT -j PING",
  "-t filter -A FORWARD -j PING",
  "-t filter -A OUTPUT --protocol udp --dport 53 --jump ACCEPT",
  ""
]
default['chef-iptables']['rules']['0default.ipv6'] = [
  "# PING",
  "-t filter -N PING",
  "-t filter -A PING -p icmpv6 --icmpv6-type echo-request --match limit --limit 6/minute --limit-burst 5 -j ACCEPT",
  "-t filter -A PING -p icmpv6 --icmpv6-type echo-reply -j ACCEPT",
  "-t filter -A INPUT  -j PING",
  "-t filter -A OUTPUT -j PING",
  ""
]

default['chef-iptables']['ipv4rules']['filter']['INPUT']['ssh'] = '--protocol tcp --dport 22 --sport 1024:65535 --match state --state NEW --jump ACCEPT'
default['chef-iptables']['ipv4rules']['filter']['OUTPUT']['ntp'] = '--protocol udp --dport 123 --jump ACCEPT'
default['chef-iptables']['ipv4rules']['filter']['OUTPUT']['syslog'] = ['--protocol udp --dport 514 --jump ACCEPT', '--protocol tcp --dport 514 --match state --state NEW --jump ACCEPT']
default['chef-iptables']['ipv4rules']['filter']['OUTPUT']['apt-cacher-ng'] = '--protocol tcp --dport 3142 --match state --state NEW --jump ACCEPT'
default['chef-iptables']['ipv4rules']['filter']['OUTPUT']['mail'] = '--protocol tcp --dport 25 --match state --state NEW --jump ACCEPT'
default['chef-iptables']['ipv4rules']['filter']['OUTPUT']['https'] = '--protocol tcp --dport 443 -m state --state NEW --jump ACCEPT'
default['chef-iptables']['ipv4rules']['filter']['FORWARD']['default'] = nil
# on limite le nombre de demandes de connexions :
#default['chef-iptables']['ipv4rules']['filter']['FORWARD']['DDOS'] = [
# '-p tcp --syn -m limit --limit 4/second -j ACCEPT',
# '-p udp -m limit --limit 4/second -j ACCEPT',
# '-p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 4/s -j ACCEPT'
#]

default['chef-iptables']['ipv4rules']['nat']['PREROUTING']['default'] = nil
default['chef-iptables']['ipv4rules']['nat']['POSTROUTING']['default'] = nil

default['chef-iptables']['ipv4rules']['mangle']['INPUT']['default'] = nil
default['chef-iptables']['ipv4rules']['mangle']['OUTPUT']['default'] = nil
default['chef-iptables']['ipv4rules']['mangle']['FORWARD']['default'] = nil
default['chef-iptables']['ipv4rules']['mangle']['PREROUTING']['default'] = nil
default['chef-iptables']['ipv4rules']['mangle']['POSTROUTING']['default'] = nil

default['chef-iptables']['ipv4rules']['raw']['OUTPUT']['default'] = nil
default['chef-iptables']['ipv4rules']['raw']['PREROUTING']['default'] = nil

