# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.env.enable

  config.vm.box = 'base-trusty'

  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

  config.vm.network :private_network, ip: '192.168.33.101'

  # config.vm.network :forwarded_port, guest: 80, host: 80

  config.ssh.forward_agent = true

  config.vm.synced_folder "~/Projects/saltstack", '/home/koen/saltstack', type: 'nfs'
  config.vm.synced_folder "~/Projects/#{ENV['STACK']}", '/home/koen/sites', type: 'nfs'

  config.vm.provider :virtualbox do |vb|

    vb.customize ['modifyvm', :id, '--memory', '2048']
    vb.customize ['modifyvm', :id, '--cpus', '2']

  end

  config.vm.provision :shell, :path => 'bootstrap.sh'

  config.vm.provision :salt do |salt|

    salt.grains({
      roles: [ENV['STACK']]
    })

    salt.bootstrap_options = '-F -c /tmp/ -P'
    salt.minion_config = 'salt/minion'
    salt.run_highstate = true
    salt.colorize = true
    salt.log_level = 'error'
    # salt.verbose = true

    salt.install_type = 'git'
    salt.install_args = 'v2015.8.3'

  end

end
