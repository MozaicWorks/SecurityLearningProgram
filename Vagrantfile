# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "kalilinux/rolling"
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.define "MozaicWorks-SecurityLP"
  config.vm.hostname = "MozaicWorks-SecurityLP"

  config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     vb.gui = true
  
     # Customize the amount of memory on the VM:
     vb.memory = "4096"

     vb.name = "MozaicWorks-SecurityLP"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.


  config.vm.provision "file", source: "./juiceshop/", destination: "/home/vagrant/"
  config.vm.provision "file", source: "./ticketmagpie/", destination: "/home/vagrant/"
  config.vm.provision "file", source: "./threatdragon", destination: "/home/vagrant/"
  config.vm.provision "file", source: "./webgoat", destination: "/home/vagrant/"

  config.vm.provision "shell", inline: <<-SHELL
     apt-get update

     # Install docker
     apt-get -y install docker.io
     systemctl enable docker --now 
     usermod -aG docker vagrant 

     # Install vscode
     apt-get install code-oss -y

     # Install container juiceshop as a service
     docker build -t juiceshop /home/vagrant/juiceshop/
     docker create -p3000:3000 --name=juiceshop juiceshop
     ln -s /home/vagrant/juiceshop/docker.juiceshop.service /etc/systemd/system/
     systemctl enable docker.juiceshop
     service docker.juiceshop start

     # Install container ticketmagpie as a service
     docker build -t ticketmagpie /home/vagrant/ticketmagpie/
     docker create -p8080:8080 --name=ticketmagpie ticketmagpie
     ln -s /home/vagrant/ticketmagpie/docker.ticketmagpie.service /etc/systemd/system/
     systemctl enable docker.ticketmagpie
     service docker.ticketmagpie start

     # Install container webgoat as a service
     docker build -t webgoat /home/vagrant/webgoat/
     docker create -p8080:8080 -p9090:9090 -eTZ=Europe/Bucharest --name=webgoat webgoat
     ln -s /home/vagrant/webgoat/docker.webgoat.service /etc/systemd/system/
     #systemctl enable docker.webgoat
     #service docker.webgoat start

     # Install OWASP Threat Dragon
     cd /usr/share/applications/ && wget https://github.com/OWASP/threat-dragon/releases/download/v1.6.1/OWASP-Threat-Dragon-1.6.1.AppImage
     chmod a+x /usr/share/applications/OWASP-Threat-Dragon-1.6.1.AppImage
     ln -s /usr/share/applications/OWASP-Threat-Dragon-1.6.1.AppImage /usr/share/applications/threatdragon
     cp /home/vagrant/threatdragon/ThreatDragon.desktop /usr/share/applications/
  SHELL

end
