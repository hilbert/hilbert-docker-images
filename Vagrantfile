# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "phusion/ubuntu-14.04-amd64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = true

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
#  config.vm.network "forwarded_port", guest: 631, host: 6631,
#      auto_correct: true

# http://stackoverflow.com/questions/16244601/vagrant-reverse-port-forwarding
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.9.9"

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
  config.vm.provider "virtualbox" do |vb|

     vb.name = "dockappvm"
  
     # Display the VirtualBox GUI when booting the machine
     vb.gui = true
  
     # number of CPU cores
     vb.cpus = 2
     vb.customize ["modifyvm", :id, "--cpus"  , 2]

     # Customize the amount of memory on the VM:
     vb.memory = "512"
     vb.customize ["modifyvm", :id, "--memory", "512"]
     
#     vb.customize ["modifyvm", :id, "--disk_size", "4000"]
#     vb.customize ["storagectl", :id, "--name", "SATA Controller", "--remove"]

     # Performance enhancements from http://blog.jdpfu.com/2012/09/14/solution-for-slow-ubuntu-in-virtualbox
     # & https://github.com/ingenerator/ingen-base-box/blob/master/Vagrantfile
     vb.customize ["modifyvm", :id, "--chipset", "ich9"]         # Chipset ICH9
      
     vb.customize ["modifyvm", :id, "--ioapic", "on"]            # IO APIC On
     vb.customize ["modifyvm", :id, "--accelerate3d", "on"]      # 3D acceleration on
     vb.customize ["modifyvm", :id, "--vram", "64"]              # Video Memory

     vb.customize ["modifyvm", :id, "--audio", "coreaudio", "--audiocontroller", "ac97"] # Enable audio?

     vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
     # due to https://github.com/jpetazzo/pipework
     vb.customize ['modifyvm', :id, '--nicpromisc1', 'allow-all']
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  config.push.define "atlas" do |push|
     push.app = "malex984/dockvm"
  end


  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.

#  config.vm.provision "file", source: ".xinitrc", destination: "/usr/src/.xinitrc"
#  config.vm.provision "file", source: "ilkh.sh", destination: "/usr/local/bin/ilkh.sh"
#  config.vm.provision "file", source: "setup_vb.sh", destination: "/usr/local/bin/setup_vb.sh"
 
#    DEBIAN_FRONTEND=noninteractive apt-get upgrade
# xserver-xephyr 

  config.vm.provision "docker" do |d|
      d.pull_images "phusion/baseimage:0.9.16"
#      d.pull_images "malex984/dockapp:base"
#      d.pull_images "malex984/dockapp:dummy"
#      d.pull_images "malex984/dockapp:main"
#      d.pull_images "malex984/dockapp:appchoo"
#      d.pull_images "malex984/dockapp:x11"
#      d.pull_images "malex984/dockapp:alsa"
#      d.pull_images "malex984/dockapp:gui"
#      d.pull_images "malex984/dockapp:test"
#    d.run "ubuntu", cmd: "bash -l", args: "-v '/vagrant:/var/www'"
  end
  
# svgalib-bin pciutils 
  config.vm.provision "shell", inline: <<-SHELL
    gpasswd -a vagrant video && gpasswd -a vagrant audio
    DEBIAN_FRONTEND=noninteractive apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -qqy --force-yes  --no-install-recommends p7zip-full curl wget sudo xauth x11-xserver-utils cups-bsd socat
    wget -q -nc -c -O "/usr/local/bin/vb_ga.sh" "https://raw.githubusercontent.com/malex984/dockapp/poc0/vb_ga.sh"
    wget -q -nc -c -O "/usr/local/bin/runme.sh" "https://raw.githubusercontent.com/malex984/dockapp/poc0/runme.sh"
    chmod +x /usr/local/bin/runme.sh
    sh /usr/local/bin/vb_ga.sh
    dpkg --list | awk '{ print $2 }' | grep 'linux-image-3.*-generic' | grep -v `uname -r` | xargs apt-get -y purge
    dpkg --list | awk '{ print $2 }' | grep linux-source | xargs apt-get -y purge
    apt-get -y purge ppp pppconfig pppoeconf popularity-contest
    apt-get -y autoremove
    apt-get -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /tmp/chef*deb
    su - vagrant -c 'cd && wget -q -nc -c -O ".bash_login" "https://raw.githubusercontent.com/malex984/dockapp/poc0/.bash_login"'
    perl -pi -e 's%exec /sbin/getty -8 38400 tty1%exec /bin/login -f vagrant < /dev/tty1 > /dev/tty1 2>&1 %' /etc/init/tty1.conf
    reboot
  SHELL

#  config.vm.synced_folder ".", "/vagrant"

 #config.vm.provision :shell, path: "runme.sh", run: "always", privileged: false #args?

#  config.ssh.forward_x11 = true
end
