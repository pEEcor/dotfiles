#!/bin/bash

CONFIG="title	Arch Linux
linux	/vmlinuz-linux
initrd	/initramfs-linux.img
options	cryptdevice=/dev/nvme0n1p2:main root=/dev/mapper/main-root rw lang=en init=/usr/lib/systemd/systemd locale=en_US.UTF-8"

echo $CONFIG > /boot/loader/entries/arch-uefi.conf
