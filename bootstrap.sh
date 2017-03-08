#!/usr/bin/env bash
echo "Installing packages"
export DEBIAN_FRONTEND=noninteractive
aptitude -y install python-m2crypto python-augeas

echo "Creating symbolic links for salt root and pillar folder"
if [ "$(id -u)" != "0" ]
  then
    ln -s ~/Projects/saltstack/salt/roots/ /srv/salt
    ln -s ~/Projects/saltstack/salt/pillar/ /srv/pillar
  else
    ln -s /home/koen/saltstack/salt/roots/ /srv/salt
    ln -s /home/koen/saltstack/salt/pillar/ /srv/pillar
fi
