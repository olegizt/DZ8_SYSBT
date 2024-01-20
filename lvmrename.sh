#!/bin/bash
yum install -y wget
vgrename centos OlegOtusRoot
sed -i 's:/dev/mapper/centos:/dev/mapper/OlegOtusRoot:' /etc/fstab
sed -i 's:lvm.lv=centos:lvm.lv=OlegOtusRoot:g' /etc/default/grub
sed -i 's:/dev/mapper/centos:/dev/mapper/OlegOtusRoot:g;s:lvm.lv=centos:lvm.lv=OlegOtusRoot:g;s: rhgb quiet::g' /boot/grub2/grub.cfg
mkdir /usr/lib/dracut/modules.d/01test
wget -P /usr/lib/dracut/modules.d/01test/ https://raw.githubusercontent.com/olegizt/DZ8_SYSBT/main/module-setup.sh
wget -P /usr/lib/dracut/modules.d/01test/ https://raw.githubusercontent.com/olegizt/DZ8_SYSBT/main/test.sh
chmod +x /usr/lib/dracut/modules.d/01test/*.sh
mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r)

echo '#!/bin/bash' >> /usr/local/sbin/motd.sh
chmod +x /usr/local/sbin/motd.sh
echo 'printf "\e[0;37;42mПривет! Проверка настроек ДЗ №8 - \"Загрузка системы\". Перезагрузите ВМ и посмотрите процесс загрузки в графическом окне гипервизора VirtualBox.\nЕсли во время загрузки вы увидете пингвинчика - то первая часть задания выполнена.\nПосле перезагрузки и входа в систему выполните команду sudo vgs или df -h - если имя VG совпадает с OlegOtusRoot - то вторая часть задания тоже выполнена.\e[0m\n"' >> /usr/local/sbin/motd.sh
echo "PrintMotd no" >> /etc/ssh/sshd_config
systemctl restart sshd
echo '/usr/local/sbin/motd.sh' >> /etc/profile
