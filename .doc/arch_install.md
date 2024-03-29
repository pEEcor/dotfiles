# Arch and Awesome Installation

## Arch

### Preparation

[Get](https://www.archlinux.org/download/) the latest Arch image, write it to
a usb drive and afterwards boot it up in **UEFI** mode.

Load your favorite keyboard layout:

```bash
loadkeys de
```

Partition the disk(s). One UEFI partition, large enough to hold more that one
kernel (500MB should be sufficient). One other partition for the system, which
will hold an encrypted LUKS container. From now on this partition is referred to
as `/dev/nvme0n1p2`.

```bash
# partitioning
cgdisk /dev/nvme0n1

# load dm-crypt kernel module
modprobe dm-crypt
# create luks container
cryptsetup -c aes-xts-plain -y -s 512 luksFormat /dev/nvme0n1p2
# open container (maps it to /dev/mapper/lvm)
cryptsetup luksOpen /dev/nvme0n1p2 lvm
# create physical volume
pvcreate /dev/mapper/lvm
# create volume group
vgcreate main /dev/mapper/lvm
# create logical volume inside group (can be multiple volumes, here only one to be used as /)
lvcreate -L 50GB -n root main
```

Create the filesystems for boot and root and mount both partitions afterwards

```bash
mkfs.fat -F 32 -n EFIBOOT /dev/sda1         # EFI Partitionstyp [ef00]
mkfs.ext4 -L arch /dev/sda2                 # LINUX Partitionstyp [8300]

mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
```

Now we need an internet connection to install Arch! Get your NIC's name and request an IP Address:

```bash
ip link
1: lo: <LOOPBACK.....
2: eno1: <BROADCAST...

dhcpcd eno1                                 # my NIC was called eno1
```

If you need a wifi-connection type in `wifi-menu` and follow the instructions.

If you like to disable some mirrors to get Arch only from servers within your country, you can do so by commenting them out in `/etc/pacman.d/mirrorlist`.

### Installation

Then install Arch with:

```bash
pacstrap /mnt base base-devel linux linux-firmware vim lvm2 netctl git neovim sway zsh man
```

For wireless internet access install [netctl](https://wiki.archlinux.org/index.php/Netctl). It provides `wifi-menu` when certain optional requirements are installed too, namely: `wpa_supplicant dialog dhcpcd`.

### Configuration

Generate a filesystem table for your new system based on the current mounts.

```bash
genfstab -Lp /mnt > mnt/etc/fstab
```

Change root into the new system:

```bash
arch-chroot /mnt
```

Set hostname

```bash
echo myhost > /etc/hostname                   # set hostname to myhost
```

Set matching entries in `/etc/hosts`

```bash
127.0.0.1   localhost
::1         localhost
127.0.1.1   myhostname.localdomain  myhostname
```

The next configurations will be ready on first boot already

```bash
echo KEYMAP=de-latin1 > /etc/vconsole.conf   # set vconsole keyboard layout to german

# set german time
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# set global system locale to en_US.UTF-8
echo LANG=en_US.UTF-8 > /etc/locale.conf

# generate english and german
# uncomment en_US.UTF-8 and de_DE.UTF-8 from /etc/locale.gen
locale-gen
```

Now we need to generate the initial ram disk and I usually set a root password.

```bash
mkinitcpio -p linux

passwd
```

### Boot Loader

The last step will be the installation and configuration of the boot loader, which requires some packages and the creation of some files:

```bash
# don't remember if these were necessary
pacman -S efibootmgr dosfstools
```

Create the EFI boot entry

```bash
bootctl install
```

Create boot configuration `/boot/loader/entries/arch-uefi.conf` with:

```bash
title    Arch Linux
linux    /vmlinuz-linux
initrd   /initramfs-linux.img
options  cryptdevice=/dev/nvme0n1p2:main root=/dev/mapper/main-root rw lang=en init=/usr/lib/systemd/systemd locale=en_US.UTF-8
```

Edit `/boot/loader/loader.conf` to:

```bash
default   arch-uefi
timeout   1
```

### Add User

After booting up we need to reconnect to the internet, and to create a user,
this is quickly done. I prefer zsh so installing it and setting it as the
users default shell is pretty handy to have it ready when logging in as the
newly created user.

```bash
useradd -m -g users -s /bin/zsh dude                # created user with name dude

passwd dude                                         # set a password for dude

gpasswd -a dude wheel                               # add dude to the wheel group

# you might want to add dude to audio, video, games and power as well
```

Enable wheelers to execute sudo commands -> uncomment `#%wheel ALL=(ALL) ALL`
in `/etc/sudoers`.

Done: Now exit the chroot environment and reboot

```bash
exit
reboot
```

## Troubleshooting

### LVM manual access

```bash
cryptsetup luksOpen /dev/sda2 lvm       # open LUKS container in /dev/sda1

mount /dev/mapper/main-root /mnt        # mount it
```
