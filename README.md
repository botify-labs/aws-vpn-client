# Package aws-vpn-client
---

Based on [this repo](https://github.com/samm-git/aws-vpn-client) made by [samm-git](https://github.com/samm-git)

The aim of this repo is to have an easy way to connect to an Amazon Client VPN using SSO.
A convenient way to do so is a debian package installing everything needed to connect to a VPN
A single command start OpenVPN as a daemon allowing to close the terminal without worries

Note that the patched version of OpenVPN is nowhere in this repo, it is dowloaded, patched and builded When building the package.

## How to use

### Building and istalling the package
```
dpkg-buildpackage -b -rfakeroot -tc -us -uc
sudo dpkg -i ../aws-vpn_0.1-1_amd64.deb
```

### Configuration
**Yout configuration file must be `/etc/aws-vpn.conf`**

Be sure to put this fields in your openvpn counfiguration file:
- `proto`
- `remote` (vpn endpoint and port)

And also remove:
- `auth-user-pass` (we dont want to show user prompt)
- `auth-federate` (propietary AWS keyword)
- `auth-retry interact` (do not retry on failures)

Finally run `aws-vpn` to connect to you AWS VPN and `aws-vpn --kill` to disconnect.
More option are available for this command try `aws-vpn --help`

### More information
Since openvpn and the http server run as a daemon, if there is an issue the outpups are redirected to `/var/log/aws-vpn.log`