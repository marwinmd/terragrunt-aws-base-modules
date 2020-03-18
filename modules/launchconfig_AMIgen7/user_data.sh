#!/bin/bash -x
do_build=1

GEOMETRYSTRING="/:rootlv:2,swap:swaplv:1,/var:varlv:2,/tmp:tmplv:1"
vg=rootvg
volume=/dev/xvdb
MAINTUSR=ec2-user
AWSTOOLSRPM="ec2-utils ec2sys-autotune amazon-ssm-agent ec2-instance-connect"



yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y coreutils device-mapper device-mapper-event device-mapper-event-libs device-mapper-libs device-mapper-persistent-data e2fsprogs gawk git grep grub grub2 grub2-tools grubby libudev lvm2 lvm2-libs openssl parted sed sysvinit-tools unzip util-linux-ng yum-utils zip bash-completion lsof
yum update -y
 
 
mkdir ~/git
cd ~/git
git clone https://github.com/Rendanic/AMIgen7.git
cd AMIgen7

# Branch tbr for current changes with open PRs
git checkout tbr

./GetAmznLx.sh

if [ ${do_build:-0} -eq 1 ] ; then

   ./DiskSetup.sh -f ext4 -b /boot -v $vg -d "$volume" --partitioning "$GEOMETRYSTRING" ; \
   ./MkChrootTree.sh "$volume" ext4 "$GEOMETRYSTRING" ; \
   ./MkTabs.sh "$volume" /dev/${vg}/swaplv ; \
   ./ChrootBuild.sh 2>&1 | tee ~/ChrootBuild.log ; \
   ./AWScliSetup.sh ; \
   ./ChrootCfg.sh ; \
   ./GrubSetup.sh "$volume" ; \
   ./NetSet.sh ; \
   ./CleanChroot.sh ; \
   ./PreRelabel.sh ; \
   ./Umount.sh
   touch /root/amibuild.finished

fi