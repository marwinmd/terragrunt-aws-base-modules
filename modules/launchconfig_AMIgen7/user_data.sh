#!/bin/bash -x

yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y coreutils device-mapper device-mapper-event device-mapper-event-libs device-mapper-libs device-mapper-persistent-data e2fsprogs gawk git grep grub grub2 grub2-tools grubby libudev lvm2 lvm2-libs openssl parted sed sysvinit-tools unzip util-linux-ng yum-utils zip bash-completion lsof
yum update -y
 
 
mkdir ~/git
cd ~/git
git clone https://github.com/Rendanic/AMIgen7.git
cd AMIgen7
./GetAmznLx.sh