Vagrant.configure("2") do |config|

  config.disksize.size = "15GB"

  config.vm.define "dockyard" do |dockyard|

    dockyard.vm.box = "rockylinux/8"

    dockyard.vm.box_version = "4.0.0"

    dockyard.vm.provider "virtualbox" do |virtualbox|
      virtualbox.cpus = 1
      virtualbox.memory = "4096"
    end

    dockyard.vm.synced_folder ".", "/opt/patroni-etcd-haproxy"

    dockyard.vm.network "private_network", ip: "192.168.7.20"

    dockyard.vm.provision :shell, path: "dockyard-bootstrap.sh"

  end

  config.vm.define "haproxy_01" do |haproxy_01|

    haproxy_01.vm.box = "rockylinux/8"

    haproxy_01.vm.box_version = "4.0.0"

    haproxy_01.vm.provider "virtualbox" do |virtualbox|
      virtualbox.cpus = 1
      virtualbox.memory = "1024"
    end

    haproxy_01.vm.network "private_network", ip: "192.168.7.11"

    haproxy_01.vm.synced_folder "HAProxy/", "/vagrant"

    haproxy_01.vm.provision :shell, path: "HAProxy/haproxy-01-bootstrap.sh"

  end

  config.vm.define "haproxy_02" do |haproxy_02|

    haproxy_02.vm.box = "rockylinux/8"

    haproxy_02.vm.box_version = "4.0.0"

    haproxy_02.vm.provider "virtualbox" do |virtualbox|
      virtualbox.cpus = 1
      virtualbox.memory = "1024"
    end

    haproxy_02.vm.network "private_network", ip: "192.168.7.12"

    haproxy_02.vm.synced_folder "HAProxy/", "/vagrant"

    haproxy_02.vm.provision :shell, path: "HAProxy/haproxy-01-bootstrap.sh"

  end

end
