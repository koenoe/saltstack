#!/usr/bin/env bash

echo "Creating symbolic links for salt root and pillar folder"
ln -s /home/koen/saltstack/salt/roots/ /srv/salt
ln -s /home/koen/saltstack/salt/pillar/ /srv/pillar
