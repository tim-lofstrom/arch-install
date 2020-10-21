# Arch Linux

## Installation

## Boot

First, prepare USB with Arch live iso and boot from USB.

## Keyboard Layout

```
loadkeys sv-latin1
```

## Verify boot mode

Check if `/sys/firmware/efi/efivars` directory exists, if yes we are in `UEFI`. Else in `BIOS`.

1. For `UEFI` mode, use GPT partitioning.

    |      Mount point      |         Partition         |     Partition type    |      Suggested size     |
    |:---------------------:|:-------------------------:|:---------------------:|:-----------------------:|
    | /mnt/boot or /mnt/efi | /dev/efi_system_partition | EFI system partition  | At least 260 MiB        |
    | [SWAP]                | /dev/swap_partition       | Linux swap            | More than 512 MiB       |
    | /mnt                  | /dev/root_partition       | Linux x86-64 root (/) | Remainder of the device |

2. For `BIOS` mode, use MBR partitioning.

    | Mount point |      Partition      | Partition type |      Suggested size     |
    |:-----------:|:-------------------:|:--------------:|:-----------------------:|
    | [SWAP]      | /dev/swap_partition | Linux swap     | More than 512 MiB       |
    | /mnt        | /dev/root_partition | Linux          | Remainder of the device |
    |             |                     |                |                         |

## Connect to internet

1. Using internet cable, check internet connection using `ip link`.

2. Using WiFi, use tool `iwctl`

## Set system clock

Set clock using

```
timedatectl set-ntp true
```

## Partition the disks

Partition disks using fdisk

```
fdisk /dev/root_partition
```

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