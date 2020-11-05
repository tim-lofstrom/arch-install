#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

echo "=== Installing Arch Linux ==="
echo ""

# Load keyboard
echo "Select keyboard layout:"
PS3='>'
options=("sv-latin1" "skip")
select opt in "${options[@]}"
do
    case $opt in
        "sv-latin1")
            echo "Loading keys $opt"
            loadkeys -v $opt 
            break
            ;;
        "skip")
            echo "skipping..."
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

echo ""
echo "Updating system clock"
timedatectl set-ntp true
echo ""

# Verify boot mode
echo ""
echo "Checking boot mode..."

DIR="/sys/firmware/efi/efivars"
if [ -d "$DIR" ]; then
    echo "Boot mode is UEFI."
    BOOT_MODE="UEFI"
else
    echo "Boot mode is BIOS."
    BOOT_MODE="BIOS"
fi

# List physical disks
disks=$(lsblk -dp --output KNAME | grep -v 'KNAME' | grep -v '/loop')

echo ""
echo "Avaliable disks:"

for i in "$disks"
do
    info=$(fdisk -l | grep -A 1 Disk | grep -A 1 $i)
    printf "$info\n"
done

echo ""

if [ $BOOT_MODE == "UEFI" ]; then
printf 'Using UEFI boot mode. In in fdisk, press `g` to create new `GPT` table. Then set up the partitions like in the table below.'
printf "
|      Mount point      |         Partition         |     Partition type    |      Suggested size     |\n
|:---------------------:|:-------------------------:|:---------------------:|:-----------------------:|\n
| /mnt/boot or /mnt/efi | /dev/efi_system_partition | EFI system partition  | At least 260 MiB        |\n
| [SWAP]                | /dev/swap_partition       | Linux swap            | More than 512 MiB       |\n
| /mnt                  | /dev/root_partition       | Linux x86-64 root (/) | Remainder of the device |\n"
else
printf "Using BIOS boot mode. In fdisk, press `o` to create new `DOS` partition. Then set up the partitions like in the table below."
printf "
| Mount point |      Partition      | Partition type |      Suggested size     |\n
|:-----------:|:-------------------:|:--------------:|:-----------------------:|\n
| [SWAP]      | /dev/swap_partition | Linux swap     | More than 512 MiB       |\n
| /mnt        | /dev/root_partition | Linux          | Remainder of the device |\n
|             |                     |                |                         |\n"
fi

# Install base system
#packstrap /mnt 


