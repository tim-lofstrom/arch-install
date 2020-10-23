# Arch Linux

## Installation

## Boot

First, prepare USB with Arch live iso and boot from USB.

## Keyboard Layout

```
loadkeys sv-latin1
```


## Connect to internet

1. Using internet cable, check internet connection using `ip link`.

2. Using WiFi, use tool `iwctl`

## Set system clock

Set clock using

```
timedatectl set-ntp true
```

## Partition the disks

- First verify boot mode
    
    Check if `/sys/firmware/efi/efivars` directory exist
    
    - if yes we are in `UEFI` and will use `GPT` partition table
    - else we are in `BIOS` and will use `MBR` partitioning.

Partition disks using fdisk

```
fdisk /dev/root_partition
```

1. For `UEFI` mode, use GPT partitioning.

    in fdisk, press `g` to create new `GPT` table. Then set up the partitions like in the table below.

    |      Mount point      |         Partition         |     Partition type    |      Suggested size     |
    |:---------------------:|:-------------------------:|:---------------------:|:-----------------------:|
    | /mnt/boot or /mnt/efi | /dev/efi_system_partition | EFI system partition  | At least 260 MiB        |
    | [SWAP]                | /dev/swap_partition       | Linux swap            | More than 512 MiB       |
    | /mnt                  | /dev/root_partition       | Linux x86-64 root (/) | Remainder of the device |



2. For `BIOS` mode, use MBR partitioning.

    in fdisk, press `o` to create new `DOS` partition. Then set up the partitions like in the table below.

    | Mount point |      Partition      | Partition type |      Suggested size     |
    |:-----------:|:-------------------:|:--------------:|:-----------------------:|
    | [SWAP]      | /dev/swap_partition | Linux swap     | More than 512 MiB       |
    | /mnt        | /dev/root_partition | Linux          | Remainder of the device |
    |             |                     |                |                         |

## Format partitions

Format root partition

```
mkfs.ext4 /dev/root_partition
```

Format swap partition

```
mkswap /dev/swappartition
```

## Mount Filesystem

Mount root partition.
```
mount /dev/root_partition /mnt
```

Enable swap.
```
swapon /dev/swappartition
```

## Installation

Install Arch using pacstrap
```
pacstrap /mnt base linux linux-firmware
```

## Configure system

Generate fstab using

```
genfstab -U /mnt /mnt/etc/fstab
```
Chroot into the new system

```
arch-chroot /mnt
```

Set timezone

```
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
```

Edit /etc/locale.gen and uncomment en_US.UTF-8 UTF-8 and other needed locales. Generate the locales by running:

```
locale-gen
```

Set computer language
```
localectl set-locale LANG=en_IN.UTF-8
```

If you set the keyboard layout, make the changes persistent by edit `/etc/vconsole.conf`

```
KEYMAP=sv-latin1
```