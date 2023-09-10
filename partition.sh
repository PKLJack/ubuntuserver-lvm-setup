#!/usr/bin/bash
# Step - Partition
#

set -eux -o pipefail

echo '#########################'
echo '# partition table'
echo '#########################'
parted --script /dev/sda -- mktable gpt
parted --script /dev/sdb -- mktable gpt

# parted --script /dev/sda -- p ; parted --script /dev/sdb -- p


echo '#########################'
echo '# Make partitions'
echo '#########################'
# HDD
parted --script /dev/sda -- mkpart 'hdd' ext4 0% 100%

# SSD
parted --script /dev/sdb -- mkpart 'efi' fat32 1MiB 1001MiB  # make /dev/sdb1
parted --script /dev/sdb -- mkpart 'boot' ext4 1001MiB 3001MiB  # make /dev/sdb2
parted --script /dev/sdb -- mkpart 'root' ext4 3001MiB 100%   # make /dev/sdb3

# parted --script /dev/sda -- p ; parted --script /dev/sdb -- p


echo '#########################'
echo '# Set flags'
echo '#########################'

# HDD sda1
parted --script /dev/sda -- set 1 lvm on

# SSD sdb1
parted --script /dev/sdb -- set 1 boot on
parted --script /dev/sdb -- set 1 esp on

# SSD sdb3
parted --script /dev/sdb -- set 3 lvm on

# parted --script /dev/sda -- p ; parted --script /dev/sdb -- p


echo '#########################'
echo '# Make file systems'
echo '#########################'
echo 'Keep /dev/sda1 without file system.'

# SSD sdb1
mkfs.vfat -F 32 /dev/sdb1
mkfs.ext4 -q /dev/sdb2

# parted --script /dev/sdb -- p
