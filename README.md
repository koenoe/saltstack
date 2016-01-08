# My awesome stack
===================
Based on [Simplestack](https://github.com/wietsehage/simplestack) from Wietse Hage.

## Requirements

* Vagrant 1.7.4 or higher

## Installation for local development

Install following plugins:

```sh
vagrant plugin install vagrant-env
vagrant plugin install salty-vagrant-grains
vagrant plugin install vagrant-dnsmasq
```

To reinitialise:

```sh
salt-call state.highstate --local
```

To reinitialise a module:

```sh
salt-call state.sls modules.nginx --local
```

## Installation on a server
```sh
# Install git
sudo apt-get update
sudo apt-get install git

# Clone repository
cd /home/koen && git clone git@github.com:koenoe/saltstack.git

# Install salt
wget -O install_salt.sh https://bootstrap.saltstack.com
sudo sh install_salt.sh

# Bootstrap salt
sudo sh /home/koen/saltstack/bootstrap.sh

# Start salt
sudo salt-call state.highstate --local
```

### Notes ###

Mysql password: sudo cat /root/.my.cnf
