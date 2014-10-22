# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "rundeck_master" do |rundeck_master|
    rundeck_master.vm.hostname = "rundeckMaster"
    rundeck_master.vm.box = "Centos-6-4-puppet"
    rundeck_master.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20131103.box"
    rundeck_master.vm.network "forwarded_port", guest: 4440, host: 4440
    rundeck_master.vm.network "public_network", ip: "192.168.1.100"
  end

   config.vm.define "rundeck_slave" do |rundeck_slave|
    rundeck_slave.vm.hostname = "rundeckSlave"
    rundeck_slave.vm.box = "Centos-6-4-puppet"
    rundeck_slave.vm.network "public_network", ip: "192.168.1.101"
  end

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file  = "site.pp"
    puppet.options = "--verbose --debug"
  end

end