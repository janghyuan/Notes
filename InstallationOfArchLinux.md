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

