# Tower Configuration

Desktop computer related stuff.


### Automated DHCP
Enable the dhcpcd service for your network device to automatically obtain an IP-address.
```bash
systemctl enable dhcpcd@eno1        # requires root
```