#!/bin/bash

vgrename centos OlegOtusRoot
sed -i 's:/dev/mapper/centos:/dev/mapper/OlegOtusRoot:' /etc/fstab
sed -i 's:lvm.lv=centos:lvm.lv=OlegOtusRoot:g' /etc/default/grub
sed -i 's:/dev/mapper/centos:/dev/mapper/OlegOtusRoot:g;s:lvm.lv=centos:lvm.lv=OlegOtusRoot:g;s:rhgb quiet ::' /boot/grub2/grub.cfg
#mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r)
mkdir /usr/lib/dracut/modules.d/01test
--wget -P /usr/lib/dracut/modules.d/01test/ https://raw.githubusercontent.com/olegizt/DZ8_SYSBT/main/*.sh
chmod +x /usr/lib/dracut/modules.d/01test/*.sh
mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r)
#reboot

