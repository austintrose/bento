#!/bin/sh -eux

# ubuntu_version="`lsb_release -r | awk '{print $2}'`";
# major_version="`echo $ubuntu_version | awk -F. '{print $1}'`";

# if [ "$major_version" -le "15" ]; then
#   echo "Disabling automatic udev rules for network interfaces in Ubuntu"
#   # Disable automatic udev rules for network interfaces in Ubuntu,
#   # source: http://6.ptmc.org/164/
#   rm -f /etc/udev/rules.d/70-persistent-net.rules;
#   mkdir -p /etc/udev/rules.d/70-persistent-net.rules;
#   rm -f /lib/udev/rules.d/75-persistent-net-generator.rules;
#   rm -rf /dev/.udev/ /var/lib/dhcp3/* /var/lib/dhcp/*;
# fi

# Set up eth0
echo "auto eth0\niface eth0 inet dhcp" >> /etc/network/interfaces.d/eth0.cfg

# Adding a 2 sec delay to the interface up, to make the dhclient happy
echo "pre-up sleep 2" >>/etc/network/interfaces;

sed -ie 's/GRUB_CMDLINE_LINUX="\(.*\)"/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0 \1"/g' /etc/default/grub
update-grub
