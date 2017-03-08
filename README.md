# My awesome stack
Based on [Simplestack](https://github.com/wietsehage/simplestack) from Wietse Hage.

## Requirements

* Vagrant 1.7.4
* Virtualbox 5.0.0-101573

## Install older version of Vagrant
```sh
brew cask install vagrant; brew cask edit vagrant;
```
Change version to 1.7.4
```sh
brew cask fetch vagrant
```
Copy actual sha256 hash and paste it in the same file where you changed the version.
```sh
brew cask uninstall --force vagrant; brew cask install vagrant; rm -rf ~/.vagrant.d/;
```
## Install older version of Vagrant
```sh
brew cask install virtualbox; brew cask edit virtualbox;
```
Change version to 5.0.0-101573
```sh
brew cask fetch virtualbox
```
Copy actual sha256 hash and paste it in the same file where you changed the version.
```sh
brew cask uninstall --force virtualbox; brew cask install virtualbox;
```

## Installation for local development

Install following plugins:
```sh
vagrant plugin install vagrant-env salty-vagrant-grains vagrant-dnsmasq
```

Start Vagrant:
```sh
vagrant up
```

To ssh to Vagrant:
```sh
ssh user@ip-address
```

To reinitialise a module:
```sh
sudo salt-call state.sls modules.nginx --local
```

## Installation on a server
```sh
# Install git
sudo apt-get update
sudo apt-get install git python-m2crypto python-augeas

# Clone repository
mkdir home/koen && cd /home/koen && git clone https://github.com/koenoe/saltstack.git

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
