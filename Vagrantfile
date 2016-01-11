# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Environment variables
  config.env.enable

  # Enable dnsmasq on .local domains
  config.dnsmasq.domain = '.vagrant'
  config.dnsmasq.ip = ENV['IP']

  # overwrite default location for /etc/dnsmasq.conf
  config.dnsmasq.dnsmasqconf = '/usr/local/etc/dnsmasq.conf'

  # command for reloading dnsmasq after config changes
  config.dnsmasq.reload_command = 'sudo launchctl unload -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist; sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist'

  # Forward ssh, so we can login with our users created on the Vagrant box
  config.ssh.forward_agent = true

  config.vm.box = 'base-trusty'
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'
  config.vm.network :private_network, ip: ENV['IP']

  config.vm.synced_folder "~/Projects/saltstack", '/home/koen/saltstack', type: 'nfs'
  config.vm.synced_folder "~/Projects/#{ENV['LANGUAGE']}", '/home/koen/sites', type: 'nfs'

  config.vm.provider :virtualbox do |vb|

    vb.customize ['modifyvm', :id, '--memory', '2048']
    vb.customize ['modifyvm', :id, '--cpus', '2']

  end

  config.vm.provision :shell, path: 'bootstrap.sh'

  config.vm.provision :salt do |salt|

    salt.grains({
      language: ENV['LANGUAGE'],
      database: ENV['DATABASE']
    })

    salt.bootstrap_options = '-F -c /tmp/ -P'
    salt.minion_config = 'salt/minion'
    salt.run_highstate = true
    salt.colorize = true
    salt.log_level = 'error'

    salt.install_type = 'git'
    salt.install_args = 'v2015.8.3'

  end

end
