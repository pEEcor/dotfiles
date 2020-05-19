# Blade Stealth (Early 2019) Configuration

## Network

Enable resolvconf to avoid direct usage of `/etc/resolv.conf` from dhcpcd from multiple interfaces (including VPN).
```bash
systemctl enable systemd-resolved.service
```

Enable automatic wifi connection for interface `wlo1` to available networks (requires configuration for network in `/etc/netctl/`).

```bash
systemctl enable netctl-auto@wlo1.service
```

## Disable MX150
For some reason, `bbswitch` alone does not disable the dedicated graphics card, but bumblebeed does, if bbswitch is installed. This solves the weired issue where sway takes ~10s to start.

```bash
# install bbswitch and bumblebee (no configuration required)
pacman -S bbswitch bumblebee
```

## MISC

```bash
# enable trim
systemctl enable fstrim.timer

# enable time sync
systemctl enable systemd-timesyncd.service
```