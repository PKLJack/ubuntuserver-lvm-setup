#!/usr/bin/bash
# Step - Reset
#

set -eux -o pipefail

echo '#########################'
echo '# Reset'
echo '#########################'

# Reset LVM
lvdisplay -c | cut -d ':' -f 1 | xargs -r lvremove -f # `-f` flag needed
vgdisplay -c | cut -d ':' -f 1 | xargs -r vgremove
pvdisplay --separator=':' --columns --noheadings | cut -d ':' -f 1 | xargs -r pvremove

# Unmount stuff
umount /dev/sda
umount /dev/sdb

# Reset devices
wipefs --all /dev/sdb
wipefs --all /dev/sda
