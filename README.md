# Installation Preparation script for Ubuntu Server

Preparation script for LVM install on Ubuntu Server.

## Physical Volumes (PV)

```
HDD:
	- /dev/sda (30GiB)
		- /dev/sda1 (30GiB) LVM
SSD:
	- /dev/sdb (20GiB)
		- /dev/sdb1 (1GiB)
		- /dev/sdb2 (2GiB)
		- /dev/sdb3 (???GiB) LVM
```

## Usage

```sh
git clone https://github.com/PKLJack/ubuntuserver-lvm-setup.git
cd ubuntuserver-lvm-setup
chmod u+x *.sh

# Run
./reset.sh && partition.sh && lvm.sh
```
