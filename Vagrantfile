# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'
IP_ADDRESS = '192.168.33.101'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Enable dnsmasq on .local domains
  config.dnsmasq.domain = '.vagrant'
  config.dnsmasq.ip = IP_ADDRESS

  # overwrite default location for /etc/dnsmasq.conf
  config.dnsmasq.dnsmasqconf = '/usr/local/etc/dnsmasq.conf'

  # command for reloading dnsmasq after config changes
  config.dnsmasq.reload_command = 'sudo launchctl unload -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist; sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist'

  config.vm.box = 'base-trusty'
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

  config.vm.network :private_network, ip: IP_ADDRESS
  config.vm.network :forwarded_port, guest: 80, host: 8080

  config.ssh.forward_agent = true
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"
  config.ssh.insert_key = false

  config.vm.synced_folder "~/Projects/saltstack", '/home/koen/saltstack', nfs: true, mount_options: ['actimeo=2']
  config.vm.synced_folder "~/Projects/php", '/home/koen/sites', nfs: true, mount_options: ['actimeo=2']

  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.customize ['modifyvm', :id, '--memory', '2048']
    vb.customize ['modifyvm', :id, '--cpus', '2']
    vb.customize ['modifyvm', :id, '--cableconnected1', 'on']
  end

  config.vm.provision :shell, path: 'bootstrap.sh'

  config.vm.provision :salt do |salt|

    salt.bootstrap_options = '-F -c /tmp/ -P'
    salt.minion_config = 'salt/minion'
    salt.masterless = true
    salt.run_highstate = true
    salt.colorize = true
    salt.verbose = true
    salt.log_level = 'info'

  end

end
