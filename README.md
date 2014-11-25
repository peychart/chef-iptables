# chef-iptables-cookbook

 Chef cookbook for the configuration/installation of iptables firewalls

## Supported Platforms

 Ubuntu/Debian

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['chef-iptables']['confdir']</tt></td>
    <td>String</td>
    <td>Directory where to write the iptables chains</td>
    <td><tt>/etc/iptables.d</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-iptables']['rules']</tt></td>
    <td>Hash</td>
    <td>IPV4 & IPV6 definitions</td>
    <td><tt>{"rules"=>{"default":["-P INPUT DROP", "-P OUTPUT DROP", "-P FORWARD DROP"]}}</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-iptables']['ipv4rules']</tt></td>
    <td>Hash</td>
    <td>IPV4 definitions</td>
    <td><tt>see the defaults attributes file</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-iptables']['ipv6rules']</tt></td>
    <td>Hash</td>
    <td>IPV6 definitions</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

NOTA: These defaults and the cookbook itself are given without any warranty. It is the responsibility of the user of this cookbook to check itself the result of its operation ...

## Usage

### chef-iptables::default

Include `chef-iptables` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[chef-iptables::default]"
  ]
}
```

## License and Authors

Author:: PE, pf. (<peychart@mail.pf>)
