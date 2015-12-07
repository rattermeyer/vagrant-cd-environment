# -*- mode: ruby -*-
# vi: set ft=ruby :

boxes = {
    :ansiblectrl => { :name => "ansible-control", :eth1 => "192.168.205.10", :mem => "1536", :cpu => "1" },
    :controller  => { :name => "controller", :eth1 => "192.168.205.11", :mem => "2048", :cpu => "2" },
    :gocdslave1  => { :name => "gocd-slave-1", :eth1 => "192.168.205.12", :mem => "2048", :cpu => "2" },
    :gocdslave2  => { :name => "gocd-slave-2", :eth1 => "192.168.205.13", :mem => "2048", :cpu => "2" },
    :repository  => { :name => "repository", :eth1 => "192.168.205.14", :mem => "4096", :cpu => "1" },
    :dh1 => { :name => "dh1", :eth1 => "192.168.205.15", :mem => "2048", :cpu => "2" },
    :dh2 => { :name => "dh2", :eth1 => "192.168.205.16", :mem => "2048", :cpu => "2" },
    :graylog => { :name => "graylog", :eth1 => "192.168.205.17", :mem => "5120", :cpu => "2" },
}

default_box = "ubuntu/trusty64"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  #config.vm.synced_folder "./vagrant", disabled: true

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
        sudo apt-get update
        sudo apt-get install -y python2.7
      SHELL
    end
  end

  config.vm.define "ansible-control" do |controller|
    controller.vm.provision "file", source: "ansible", destination: "/home/vagrant/.ssh/ansible"
    controller.vm.provision "shell", inline: <<-SHELL
      sudo chown vagrant: /home/vagrant/.ssh/ansible
      sudo chmod u+rw,go-rwx /home/vagrant/.ssh/ansible
      sudo apt-get update
      sudo apt-get install -y git vim software-properties-common
      sudo apt-add-repository ppa:ansible/ansible
      sudo apt-get update
      sudo apt-get install -y ansible
      sudo apt-get upgrade -y
    SHELL
  end

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
end
