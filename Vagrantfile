# -*- mode: ruby -*-
# vi: set ft=ruby :

boxes = {
    :controller  => { :name => "controller", :eth1 => "192.168.205.11", :mem => "2048", :cpu => "2" },
    :gocdslave1  => { :name => "gocd-slave-1", :eth1 => "192.168.205.12", :mem => "2048", :cpu => "2" },
    :gocdslave2  => { :name => "gocd-slave-2", :eth1 => "192.168.205.13", :mem => "2048", :cpu => "2" },
    :repository  => { :name => "repository", :eth1 => "192.168.205.14", :mem => "4096", :cpu => "1" },
    :dh1 => { :name => "dh1", :eth1 => "192.168.205.15", :mem => "2048", :cpu => "2" },
    :dh2 => { :name => "dh2", :eth1 => "192.168.205.16", :mem => "2048", :cpu => "2" },
    :graylog => { :name => "graylog", :eth1 => "192.168.205.17", :mem => "5120", :cpu => "2" },
    :ansiblectrl => { :name => "ansible-control", :eth1 => "192.168.205.10", :mem => "1536", :cpu => "1" },
}

default_box = "ubuntu/trusty64"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  boxes.each do |box_id, opts|
    config.vm.define opts[:name] do |config|
      config.vm.box = opts[:box] || default_box
      config.vm.hostname = opts[:name]

      config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", opts[:mem]]
        v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]
      end
      config.vm.network :private_network, ip: opts[:eth1]
      config.vm.provision "file", source: "ansible.pub", destination: "/home/vagrant/.ssh/ansible.pub"
      config.vm.provision "shell", inline: <<-SHELL
        cat /home/vagrant/.ssh/ansible.pub >> /home/vagrant/.ssh/authorized_keys
        sudo chown -R vagrant: /home/vagrant/.ssh
        cat /home/vagrant/.ssh/ansible.pub >> /root/.ssh/authorized_keys
        sudo chown -R root: /root/.ssh
        sudo apt-get update
        sudo apt-get install -y python2.7
      SHELL
    end
  end
  config.vm.define "ansible-control" do |ansiblectrl|
    ansiblectrl.vm.provision "file", source: "ansible", destination: "/home/vagrant/.ssh/id_rsa"
    ansiblectrl.vm.provision "file", source: "ansible", destination: "/tmp/id_rsa"
    ansiblectrl.vm.provision "shell", path: "scripts/ansible-control.sh"
  end
end
