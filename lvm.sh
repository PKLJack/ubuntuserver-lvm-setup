#!/usr/bin/bash
# Step - LVM
#

set -eux -o pipefail

echo '#########################'
echo '# LVM Stuff'
echo '#########################'


# Physical Volumes
pvcreate /dev/sdb3 /dev/sda1

#  Volume Groups
vgcreate vg_root /dev/sdb3 /dev/sda1

# Logical Volumes
echo 'VM testing'
lvcreate --yes --size 12GiB --name lv_root vg_root /dev/sdb3  # / on SSD
lvcreate --yes --size 8GiB --name lv_home vg_root /dev/sda1   # /home on HDD
lvcreate --yes --size 10GiB --name lv_var vg_root /dev/sda1   # /var on HDD

# Make file systems on logical volumes
mkfs.ext4 -q /dev/mapper/vg_root-lv_home
mkfs.ext4 -q /dev/mapper/vg_root-lv_root
mkfs.ext4 -q /dev/mapper/vg_root-lv_var
