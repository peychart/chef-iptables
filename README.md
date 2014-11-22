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
    <td><tt>['chef-iptables']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

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
