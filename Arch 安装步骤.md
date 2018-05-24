## Download the ISO file and create a bootable media(U disk)

__Download Links:__ https://www.archlinux.org/download/

__Create bootable media:__ https://etcher.io/

## Check network

`ip a` check ip address or `wifi-menu` if you don't have a cable internet connection, just try the wifi alternative or `dhcpcd` to gain an ip address from dhcp server.

## Partition

### check your disk

`fdisk -l` select your correct disk name like `/dev/sda`

### partition your disk

1. `fdisk /dev/sda`
2. partition table type: DOS. `o` to select
3. `n` new partition and default ...
4. `+5G` create 5 Gegabyte for `/` and another 3 Gegabytes for `/home`
5. `w` write to changes.

### formating your disk

`mkfs.ex4 /dev/sda1`

## mount the partition

```
mount /dev/sda1 /mnt
mkdir /mnt/home
mount /dev/sda2 /mnt/home
```

## pacstrap installation

`pacstrap -i /mnt base` install the base system to the actural hard drive

## generate fstab

`genfstab -U -p /mnt >> /mnt/etc/fstab`

## software install 

`arch-chroot /mnt`

`pacman -S openssh grub-bios linux-headers linux-lts linux-lts-headers`

`pacman -S dialog network-manager-applet networkmanager networkmanager-openvpn wireless_tools wpa_supplicant wpa_actiond`

`mkinitcpio -p linux`

`mkinitcpio -p linux-lts`

## locale and grub

`nano /etc/locale.gen` uncomment en_US.UTF-8 UTF-8

`locale-gen`

`passwd` set root password

`grub-install --target=i386-pc --recheck /dev/sda`

`cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo`

`grub-mkconfig -o /boot/grub/grub.cfg`

## swapfile

`fallocate -l 2G /swapfile`

`chmod 600 /swapfile`

`mkswap /swapfile`

`echo '/swapfile none swap sw 0 0' | tree -a /etc/fstab`

## wrap up

`exit`

`umount -a`

`poweroff`

## after reboot

You don't have network. you have to enable network by your own.

`systemctl start NetworkManager`

`systemctl enable NetworkManager` this command will start Network when booted

`useradd -m janghuan` add a new user with `-m` home directory

`userdel -r username` delete the user and home directory


## User Interface

`pacman -S xorg-server`

`lspci` check your video card

- Intel: `pacman -S xf86-video-intel libgl mesa`
- Nvidia: `pacman -S nvidia nvidia-lts nvidia-libgl mesa`
- VBOX: `pacman -S virtualbox-guest-utils virtualbox-guest-modules-arch mesa` and `systemctl enable vboxservice.service` and start

`pacman -S lightdm lightdm-gtk-greeter` and `systemctl enable lightdm`

`pacman -S mate mate-extra`




