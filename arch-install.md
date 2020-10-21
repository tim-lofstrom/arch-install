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
2. For `BIOS` mode, use MBR partitioning.

## Connect to internet

1. Using internet cable, check internet connection using `ip link`.

2. Using WiFi, use tool `iwctl`

## Set system clock

Set clock using

```
timedatectl set-ntp true
```